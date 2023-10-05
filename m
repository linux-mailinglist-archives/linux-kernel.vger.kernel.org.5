Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985747BA327
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbjJEPwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbjJEPu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:50:59 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 Oct 2023 07:09:50 PDT
Received: from esa2.hc3370-68.iphmx.com (esa2.hc3370-68.iphmx.com [216.71.145.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDB2660F1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1696514990;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=jhJprP/Y3sHqA4lYHNR4CrEhesGEw8hOqJOA6HojK/E=;
  b=Shd+07c0k5gB4mNdR2JB1j0cl4Yb6UURoyJDFFIVR7ooNrpPnpSlkScl
   B67Pf3zI3q405UviWFSEfeKAbqWI64p0OPgc5IJ9EzRDGBQZPMXmbjPWU
   bswgWo2cw8KOpXEKtLZT0orA8yhsE/5nExsB2Wy0j9zI8xI2tZDRRNt0o
   U=;
X-CSE-ConnectionGUID: BQPX1hoCTpGHuhImxarX4g==
X-CSE-MsgGUID: 5TyoGeXGQn662gXGyV5Qzw==
X-IronPort-RemoteIP: 104.47.59.169
X-IronPort-MID: 124588987
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:HdsAyK0uuXaGxn3bZ/bD5ZNxkn2cJEfYwER7XKvMYLTBsI5bpz0En
 zAfC22FPPzfYWCkKdlwaYS1oRwOvZ+ByNNrTVc/pC1hF35El5HIVI+TRqvS04F+DeWYFR46s
 J9OAjXkBJppJpMJjk71atANlVEliOfQAOK6UbaYUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8teTb83uDgNyo4GlD5wRmOKgR1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfK1h2x
 aUYLxsxdj+jmuKXxaKyUNkwiZF2RCXrFNt3VnBI6xj8VKxjbbWdBqLA6JlfwSs6gd1IEbDGf
 c0FZDFzbRPGJRpSJlMQD5F4l+Ct7pX9W2QA9BTJ+uxqsi6Kkl0ZPLvFabI5fvSQQspYhACAr
 3/u9GXlGBAKcteYzFJp91r13LOSzXOqCN16+LuQq8J7h3Ke9kMqDkNID1SLjuiH13esRIcKQ
 6AT0m90xUQoz2SvT9/gT1i7rWSCsxo0RdVdCas55RuLx66S5ByWbkAbQz8HbN07nMw7Xzon0
 hmOhdyBLSRmrbm9WX+bsLCOoluaNSELIGoqaSYaQA4B5Nf/5oc+knrnQ9p+Faeng8HdFjb3z
 DSH6iM5gt07jtMB3o248ErBjjbqoYLGJiYt7w/aWGON9A51ZIe5IYev7DDz5/ZdMI2ZT1+Op
 1AfnMyX9u4KBIuA0ieKRY0lDLyvovqILjDYqVpuBIU6sSSg/Wa5eoJd6y04I11mWu4CdCPlb
 VH7pwxc/tlQMWGsYKsxZJi+Y/nG1oDlHNXhE/zRMNxHZ8ErcBfdpX8/I0mNw2rqjU4g17klP
 ouWetqtCnBcDrl7yD2xRKEW1rpDKj0C+F4/jKvTl3yPuYdyrlbOIVvZGDNittwE0Z4=
IronPort-HdrOrdr: A9a23:L8kFEK4NPcTZKfYNmQPXwPPXdLJyesId70hD6qkRc20tTiX8ra
 uTdZsgpHjJYVoqKRIdcKm7WJVoIkmsk6Kdg7N9AV7KZmCP0ldASrsSj7cKqAeQfxEWmNQtsJ
 uIRJITNDQgNzlHZZeT2meF+4hJ+ra6zJw=
X-Talos-CUID: 9a23:zkGYzGwLofFWyM2AjNTPBgU+I/gVK33a50vIDG+lCUdsWLSPeQOfrfY=
X-Talos-MUID: 9a23:87JvHAj3ufVtsXTbimX6wMMpaft55IujOG80l8tY4ca0Gj1OZg6Pk2Hi
X-IronPort-AV: E=Sophos;i="6.03,203,1694750400"; 
   d="scan'208";a="124588987"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2023 10:08:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSQxKfBr/pRmoXlVFFgRSOu5iK+iotTFQWvT+pB/btllaqNmzp0+fU8131cOuT1p/WdObIENBcqci1T50LwyXvbCW20uzkarQmUntHHWwUxEUB2MOCQanCb2xHHdbt64TBOsNv89UgOlQFj6HzKKABSeHY5jackrBnVT4qTPDwJRrb/2l65C8hG+ixPtS4lUbI/1HZG3d+A8lbf+0j2Y4vPEojK65n+zbzYJQBYwSVLE9iBn1l9Bel55bzo1NJPC9aS7uy9T1OG03dCZJ1hmFIJIeERuchq6RHyr1qDiCtytyIGVpOLIiY9dwzngG1gGRkrolU2hA8LYAS+ChOKEpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KigcWsilP0vslTifvYlQ+ld2SeybbtsKM0+KjnKpMRU=;
 b=JnvrPKB68iUfpWUy2GN7eKkx+ngstiDfVp1p6AizFdu7zYARLFijHV86QoXquzOTzf3HRdpBNCQMwwJBKXtYwiZUgggRCJASK/He2flhpitpC4ZO/rPsfjq9eFZnUu9KwdMazWW+kaJdKI0/qlT2IeSiU7xnFvfZtw3g2p2I4t+Qq4FaCFKff1gDbGybeaassL1q17cwxqY1zltHnXwfjgs0taQoU2Ypq/7lj9O3nfJ0vbbiaq+Q7ofEa4Fp/9bvhvoW7SoDfgofmZ47I3F7b4wz0fmULPgVwAV5bA5oQ5l1KDgK5QT1IO9NJWMTuUKb3rYlI0DMzBaVrqNdgK7SGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KigcWsilP0vslTifvYlQ+ld2SeybbtsKM0+KjnKpMRU=;
 b=adfpJFuJ7UkgZvXd5+WdNT2u33cBPoMZF8SzkaI9tbdLFDfGz08yQibCS+Dp7NlWmROJv3LEf3tbJ6OL+alRHEQBfuxX6LtJLKfxXxGvxd6mA0JsZJc0pnvRApQRooJYosEGC9h33i/WE+bDTnri8EY+VkUvVA0hsKQkLq7mbng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com (2603:10b6:a03:38d::21)
 by PH7PR03MB7440.namprd03.prod.outlook.com (2603:10b6:510:2f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Thu, 5 Oct
 2023 14:08:41 +0000
Received: from SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::66ca:3a42:baeb:9ecf]) by SJ0PR03MB6423.namprd03.prod.outlook.com
 ([fe80::66ca:3a42:baeb:9ecf%6]) with mapi id 15.20.6838.030; Thu, 5 Oct 2023
 14:08:41 +0000
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Wei Liu <wei.liu@kernel.org>, Paul Durrant <paul@xen.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ian Campbell <Ian.Campbell@citrix.com>,
        Ben Hutchings <bhutchings@solarflare.com>,
        xen-devel@lists.xenproject.org, netdev@vger.kernel.org
Subject: [PATCH] xen-netback: use default TX queue size for vifs
Date:   Thu,  5 Oct 2023 16:08:31 +0200
Message-ID: <20231005140831.89117-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.42.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0155.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::16) To SJ0PR03MB6423.namprd03.prod.outlook.com
 (2603:10b6:a03:38d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB6423:EE_|PH7PR03MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 1850646c-1257-49ab-4613-08dbc5ac93dd
X-LD-Processed: 335836de-42ef-43a2-b145-348c2ee9ca5b,ExtAddr,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWtaSkDfB7xzl/7GZiV7b/vuA5pbvvDcB9kXu3R27SNpIXCrrmCwcb4ZVIhLXgTKlFgrsUVG9UqlcM1XwnuxeCdBcQ97dX273ymbHfTZg58QQ7TEcIL93VahZ/s1gUsNInZ+yh0aRoUMCxuBOn1oPOJOemAKvl8oIj6/CHeTe3oVkRSzhLFqLQO6yP06Eeicwza06OanDen18/1UUZuGonSJoDjrsZ/iZ5aILvsbHB7cmJ4N5J9tKb8zStB4Cm+Xh7SalINs/g1GUnWbpKSIGg8zhnO1krNVp45RWavJ9BPVbJUgiWMYvTXXRMa+jyOzYzYQLhEao7mVVM4e0+LvEYqd6fOPC8QwTBaml4yZhWWu146VCdaRalDhhnqN8rEyBima8QIlUsdwSqXNQUE8OyUxY+TAXlw5B/y83LvtmvgFJCOVr4uN2b8VkeWmJfHJIAlSwiS9sYPqGqNCbn+JVscE9K9xIujM0ntAZnjNm2BSiUv4wUqU5fZNaYxk5MgAIJ1mw4XtJ/kFVauLOQyuQng+uYHLcJObINX1X1ACxWyxNvT1VxY+NCrcrmORbAuC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6423.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2616005)(66556008)(66476007)(54906003)(66946007)(6916009)(316002)(41300700001)(1076003)(6512007)(26005)(6666004)(36756003)(6506007)(478600001)(6486002)(38100700002)(82960400001)(86362001)(83380400001)(7416002)(2906002)(4326008)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlY3cTl4S0wyS1pnVmY2TW1yTmMwcTFQWHJadStoMitwVnVERlNzVTVnNFA1?=
 =?utf-8?B?WmxpdW1mME1sZ09lUmJ1K25tcGgxZFFBN3Bub3poNS8wdGtRam9qL2hvelVs?=
 =?utf-8?B?N0gyZlFKWis0ZTVVNld0TktXSjZwdzBrbWFaS0I4cEVKdFF0V3pFZ0RzMENC?=
 =?utf-8?B?T0FQbUd4UjlCVDc5cVozNVZtZHgwbEVsOE1wb1FoaFVtVkxxSXphcW9BTGlh?=
 =?utf-8?B?bUpMeVNkKzQ3bUFBcjRORXorcyswZURybCtwSFZRTnBtSmpKbXNXU3dUV0RC?=
 =?utf-8?B?OHU0T3pzdGZZOHkxZHh2WUdRMU1VTzlYYVdwVmtTZVBydzk2T29MWFpvbm1W?=
 =?utf-8?B?OHMvb3ExSGkySC9XdTBmSzIrMkN0NVc4WFNIQmpHV0hHd291QTQ5M00rNExq?=
 =?utf-8?B?NjlsaXFtSzBTMFQyWTBjTVpNdkFRUE53Z1hSOGc4dit0dkpieEhvaVZRMUZn?=
 =?utf-8?B?N0V5VWRKY2xQK2xuZkRIR3k2Q1NlVzc2U2lKTzFEUDVrK1d0RFdsSU5tcFRX?=
 =?utf-8?B?NUxxL3M0SjFpYlZEVVRKTTExakpQa05tL0lvdEpSRFBCNVAwSFVTdHJXZEpp?=
 =?utf-8?B?UmNFYXZHYTRqYU9IRVlPZTkwd3VESXovVkpQVG5ySWZNN0d4a2FjSjVEbHpv?=
 =?utf-8?B?ekpkejRGSjJvblRLSmZIVDhCa2ZLOGZzelFPbFRCR1d1bGliSTFjcWhCTVRl?=
 =?utf-8?B?U0lTYW1Fd1JMNlJ6Q2hpMDlmMUJWK3VuNGlsMm85Tmg5VmROSS95YmFQcVo1?=
 =?utf-8?B?ckpXU0g3OVlnamMxR3VtcEFhUWpJMWwwc0dGYlJyZG10aVM5bGRhWWhCbitV?=
 =?utf-8?B?M1crZFhSU0hhd0FBWXZ3aGM4SWhFb3REMHZoejhyVlpxUGZUVm9nR2ZjRm1u?=
 =?utf-8?B?ZW84cWtESzZNWlg1Q0hiRjhkbG5qTzA0UFNYSEtkSThvMGpKdWVySnRLRlpq?=
 =?utf-8?B?cHg1MXV6MWxreE1KV0llY1lndjk5WEkvTlFuK2Q1T0NydjdyNVpQd1gwcnI5?=
 =?utf-8?B?RVFXdVdXdU1JSFlSYklEd0ROZndLWFFmcXdpYzI0WkNHYlNib0hyQ3FBZnNG?=
 =?utf-8?B?UmxJSVRncEhEYlVWbDF3OWUrN3ovR0FWWHBqMVRSVHpXMmxyeXkreE1jTHVR?=
 =?utf-8?B?MVBwMVJoOW9IY2VDTkZvc0gvcUUzcWo4TTE4REw3MndPWE9aeWl0VFNLZGN4?=
 =?utf-8?B?alhBMWx0RUJZRTFLSjdCSk41RXBhbXd2N2VkdU94VlJoVUhBcGNCc3NwRysy?=
 =?utf-8?B?R2U3UGtiYks5bFl6NHFTeWJLRnpzU1JnSEY3MFhZZ0hCNVlaaHZ0eXFQRS9X?=
 =?utf-8?B?V0tjWjgxUVJFVk5ybDZjSkNJdDRXcnRROGFQSXpQdkdWSVpic0pmallGSVBq?=
 =?utf-8?B?eXdPTzRENkwvS0t4SXluUmxrdmoyUk1YZExSaVdQU3J6R2tnU2xqUWNsZXVk?=
 =?utf-8?B?ZmJQeG9INVU4MS9aTzByamhZUmQ5dVhOc2RPS0lCcVlEWU9rZEQ0Ym9PSGJE?=
 =?utf-8?B?ZDJCem1DVENVWno0UFhQMWUwNldHNURSV01KdVpLRmN0anNjNkRRSmV0dHBD?=
 =?utf-8?B?NTY2bXBaek1BRjdIejdqdTNZS1BuZEVXalRkYWJoQy9yS1pQT3ZJK2J6MHdX?=
 =?utf-8?B?TkpVVnFNb3AvVU1Salp2eWRiOGVNYkRvb09kZ0RmQm1MYjBpcExWNDV1eENE?=
 =?utf-8?B?cCt1alZvVmM4RkFxcUNOSHB1UmhCL1dxNEIrRWJTS3luUitQaVAwTVNEcURD?=
 =?utf-8?B?TnU4M2UxR0VMa000bkRNdm5BcVR0bXVwOFNQZ1JZUFF0dndobnhuRXhaTDdh?=
 =?utf-8?B?eGJtMGpuZHVZYVM2Qkd2NEV3NEQ0dWY0Q29MZmtQaXdDRzAwS0owRUs4MEVQ?=
 =?utf-8?B?ZVZVNDVPOERyNW45UWlTa2pWZCs5OGdnd29qOXFGVVRoTW9kNEt2VVdVYWFE?=
 =?utf-8?B?M29tcGc3RjBBYndIQlVJdmJvSXp6NGhUeWJNWmoyQWJ1dzdrbktnNEFFZisx?=
 =?utf-8?B?azJ5WDVTZVJlT0RkK28zRnBjQlpvOFVFdUEwZlNzTFNSWE8zYVkyZnlpQnA4?=
 =?utf-8?B?c1dTZ3ZSc0RvS04rOHRmTkE3S0w1YWg3eU4vTWcycSthVVNQeWJkcUV5YUxn?=
 =?utf-8?Q?qfzo5OnXMBpbl0hYBi5tp7vVk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?V0NiNmVvUWp3N3d0RUlYVHVKZ2NhMGhWUktxdzR1RzdBbWhSMGVmbUF0ZmJi?=
 =?utf-8?B?U0hLR003ckN4QThxY2JVZU9qd1ZFdmxlWHFVb2ZncGx5dklDMTEzNUdYUk5O?=
 =?utf-8?B?Q2MvU2hWdDJqQS8vdHN3TCtvM3dCSUxtdTNYNHhCSEJnQTNCd0txeDB5WFZh?=
 =?utf-8?B?UXlOSFpxK3g0YnRxc2pSWXNMVTBoNGRVaWRtWDgxSndoUWJ3a1lOTzYzSHpK?=
 =?utf-8?B?bDkrcGFMdTNmenRBcEUzYVhZS1dmRTdKQmhsaU1FcnpHbU84UUcrTG9xbWRY?=
 =?utf-8?B?M213U1RmbXBkSlBybE1jV0ZSTHhOUEt2c2ZPSW1rZ0NOUFJGRW5kKzZKV25T?=
 =?utf-8?B?UlBIUlBUY1NsaGJCOWVuUlplQWEranM0cjFERFg2NitBNjg2MDRPODU0UmRa?=
 =?utf-8?B?b2VCRWFLS29Sb3kvVU9kMitIaEI5K3JTM1RISzdzMTNuRDF6ZzNGNGN5QWRq?=
 =?utf-8?B?WWJEMW5pT3A5NXcxZHNZcDJpTnkrRUpLS3ExWWo5ekdkSHI4a1JaVXFWSXoz?=
 =?utf-8?B?MzlCYkh0ZTZQbkdPZjYzR2Vjd21zZE1BbWtBT0tUUk90UURGTDluRk1QSWt0?=
 =?utf-8?B?TnVHS3hZVFU1ZHk3WURpQ3cvNmJ6SWxQVHowdnN6Rk13MEh1MGh1d2IzYWdD?=
 =?utf-8?B?QTBLeDVWMXRadzQ1aGVhb2hOeW93R0pEZ004WDZ2eHUrOWJDTTlBcEdpTytR?=
 =?utf-8?B?eklqODlxZmFFeGlWRXpmaXVGMEo4T2dPU0RzL3drYm56NDEya0YvckUvVkhl?=
 =?utf-8?B?WlpLbjY1ejEwdWdLcVF1cFF5VTcrYm5DTXBQbkdlaytHTFJsQnFDREdzb0s4?=
 =?utf-8?B?Q2Y2TmYyU3E2dmxValhFUlQzYXJ0em9uT2U0bmJpUTdrQUNIZzFtVWtKd1hP?=
 =?utf-8?B?Y1JvT3pZWTByQ2IvS3pBUEl3OXRVOXJXelFDbldzWXY5NE1LSmcrN0tSQm0w?=
 =?utf-8?B?dExCV3lJNmZhR0NHNnV4cHorcFZBYkxJUlJxcm93c3p2VE92cm14UmwwSkFz?=
 =?utf-8?B?TXFKRnlXWTdpd1NncFlYMlN3bmtLZG1pcDI1emZZMTJGRnBXSHprVlhpY2pp?=
 =?utf-8?B?VFlpclJnbEtIUVRYc080d3Irb1NRNDlUNFZieUNTME1GM0FGUjM1bGh3VDI4?=
 =?utf-8?B?QkU3dkRVdjNuUm5qY1RUc0hxWjRCOVllZ3VjdXYrYmx0RWNzWk8wTk1pcEIx?=
 =?utf-8?B?WVRLRjNTQ1Mxem9ULzJGejV6MWFIWGRXV3NTWnBRY3NNT1N6SXUwckhzUWJt?=
 =?utf-8?B?Z2tmZW5oeEk4TDhQc09DOXRiN1JRK3dseFR6cVRFOGdYZFRSYzlhYjFzc2k3?=
 =?utf-8?Q?XTv120EYn47w9OQNHejNe2VlFxZFgWZ6be?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1850646c-1257-49ab-4613-08dbc5ac93dd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6423.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 14:08:41.2413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJn5R/ra7HQWo5rksbXX/QFo4LyEmwv5ADmNwpC/pPZwTM8WypoTrswfDHjPA9EaAjSbaoFaOY7c1MHSueuMqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7440
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not set netback interfaces (vifs) default TX queue size to the ring size.
The TX queue size is not related to the ring size, and using the ring size (32)
as the queue size can lead to packet drops.  Note the TX side of the vif
interface in the netback domain is the one receiving packets to be injected
to the guest.

Do not explicitly set the TX queue length to any value when creating the
interface, and instead use the system default.  Note that the queue length can
also be adjusted at runtime.

Fixes: f942dc2552b8 ('xen network backend driver')
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
 drivers/net/xen-netback/interface.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index f3f2c07423a6..fc3bb63b9ac3 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -41,8 +41,6 @@
 #include <asm/xen/hypercall.h>
 #include <xen/balloon.h>
 
-#define XENVIF_QUEUE_LENGTH 32
-
 /* Number of bytes allowed on the internal guest Rx queue. */
 #define XENVIF_RX_QUEUE_BYTES (XEN_NETIF_RX_RING_SIZE/2 * PAGE_SIZE)
 
@@ -530,8 +528,6 @@ struct xenvif *xenvif_alloc(struct device *parent, domid_t domid,
 	dev->features = dev->hw_features | NETIF_F_RXCSUM;
 	dev->ethtool_ops = &xenvif_ethtool_ops;
 
-	dev->tx_queue_len = XENVIF_QUEUE_LENGTH;
-
 	dev->min_mtu = ETH_MIN_MTU;
 	dev->max_mtu = ETH_MAX_MTU - VLAN_ETH_HLEN;
 
-- 
2.42.0

