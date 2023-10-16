Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0B97CA970
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjJPNb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbjJPNbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:31:15 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Oct 2023 06:31:12 PDT
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0B312C
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1697463072;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=55OC0Iqruyf+AJH1Ot8Kkokj1cOZfT/LBm4X1uBmrL8=;
  b=bqUIQibmbU9eiCk+vIBBXD6/wGNXHB9eCJES0oAIU/aYhe/aujvxxXQ/
   xqi/mqd9TC3+j7vDoto+ZpUVRh7AzDtMaSvHVIS5GUsQgOSN47Z5QgBn4
   i+oV/Pu/jxEJrK/F+qoTGXiB1fmUF8/c8g9Hur93F3jbYJgj1U6MFrkDl
   I=;
X-CSE-ConnectionGUID: s/hlPEdASiSFNdktaqLHNg==
X-CSE-MsgGUID: pISjWxv2QxmsDTjgfKNPrw==
X-IronPort-RemoteIP: 104.47.55.168
X-IronPort-MID: 124951339
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:LIKoUK1wD2Ebr7y8j/bD5Uhwkn2cJEfYwER7XKvMYLTBsI5bp2QAn
 zMXDWyBa/aPYGX1L4x+O46xp0pQv8TVx9NnTgtlpC1hF35El5HIVI+TRqvS04F+DeWYFR46s
 J9OAjXkBJppJpMJjk71atANlVEliOfQAOK6UbaYUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8teTb83uDgNyo4GlD5wRnO6gS1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfGiZO8
 cQ1JBk2byutoe613LuibslKiZF2RCXrFNt3VnBI6xj8VKxja7aTBqLA6JlfwSs6gd1IEbDGf
 c0FZDFzbRPGJRpSJlMQD5F4l+Ct7pX9W2QA9BTJ+uxqvi6KklwZPLvFabI5fvSQQspYhACAr
 3/u9GXlGBAKcteYzFJp91r13LOewHqgA9N6+LuQ7t9RgmKD2DYqGBgNeWe5rvearHakRIcKQ
 6AT0m90xUQoz2SuR8P4Vge1o1aFuAAdQNtaF+Am6ACLxbHQ6gzfDW8BJhZFado7pIo1SCYs2
 1uhgdzkH3psvaeTRHbb8a2bxRuwNjISNnQqfjIfQE0O5NyLiJookhvFQ9JnEai0pt74Azf9x
 3aNtidWr7IXgM0Q3qO352fbkimsrZjESA0yzgjPV2fj5QR8DKanbYG17VnQ7d5bMZ2UCFKGu
 RAsi8WYqewDE5yJvCiMW/kWWqGk4e6fNz/RikIpGIMunwlB4FamdIFUpTt4dEFgN59efSezO
 RGD/wRM+JVUIX2mK7dtZJ68ANgryq6mEsn5UvfTbZxFZZ0ZmBK7wRyCrHW4hwjF+HXAW4lmU
 XtHWa5A1UonNJk=
IronPort-HdrOrdr: A9a23:aTtbCazrsKb5Iy8dA3SjKrPw9b1zdoMgy1knxilNoH1uA7Glfq
 WV98jzuiWUtN9vYgBHpTntAsW9qDDnhOdICPAqTMyftVDdyRGVxeJZnPffKl/bexEWn9Q1vc
 1dms5FZ+EYZmIWsS+V2meF+6tJ+qj+zEl9v5a9858QJTsaDJ2Ilz0JaTpz5XcGIDWurKBJca
 ah2g==
X-Talos-CUID: =?us-ascii?q?9a23=3AMVYDRGlpqVNFpvWBTS7irL8zVufXOWaazHPoDkO?=
 =?us-ascii?q?RMmdSZpuZSkOZ4YdEtcU7zg=3D=3D?=
X-Talos-MUID: 9a23:2dsylAtPYEb87XFmn82nnBBZNvh4/f6XGEUWvakEtMenExRqJGLI
X-IronPort-AV: E=Sophos;i="6.03,229,1694750400"; 
   d="scan'208";a="124951339"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2023 09:30:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcGuKVPkZDoKiM5zsaZ0RW1Z50Vygr9WjXg1TmQtp3SH+MTz8y3/mHpjDorIx1z3U3y13JKyiM2JBl7ui2UStOJESyOGOko64hsPq3qNNnzNBQP2V8TlyCeHxefhupyDJp9yvwhqCx/H34QcYYHQWzbeQALk2WwGmEpnX6H1NVHFuj9tutC2sEY0S2Enw47NbyEgQOrDI8V8b9WzWYGphcgXyWJj8r5ymns7wsqxPfkwdTZ7XW3Sdx1xq4314RfXBSHcsCyl2lanLDV+RTl+kK0Yi1w0LGW2BNFnoQdXzDiGq3C1rAtDv/b9WTBH21D9yctg4JM8nibOl6IZV/Al/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9pBw/0dGBycHT20MzvZTXJX1ZwYKhwOzZjQQCVeljI=;
 b=RWSS8zxUo6uHoyllo7icYt/b/ir4i2c2aiUCio0jQIEsVrYM6SRdVZciqEapEa308YFV9mDWvyhSfyPjjoN5R9ANtC4mT1DPGL/VuHwqKyIcseRDvtGU/ixNA+CP0glth42VYS0B0XKNRtSEM6kM2FIlZneNU5cwb/KUCJT1QPqOgZ01o54YJh+pQq8mLtEt7upHHjKNKg/2/aqu3RUN0eevkelDAIcEN/ZcF2/kQucurDdxnqH+pJWsVRScgKRBwfM0J9oGYCY5ODURWCVS7zsY3Wq50fITeJffbP4+kRuUDNQgK8HfYtzqkHsI+qGWs07H08Oo00YmBKQvPlsilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9pBw/0dGBycHT20MzvZTXJX1ZwYKhwOzZjQQCVeljI=;
 b=OikAqr3pVPVMcrmcI/O6BUvLVHzWyjGAb6Wjjgd6QqQb1TFEzskugFURZ1nwhkl25v2QrZbejdS77mtxJQ8cREzZQAGQ+INy5MzHmfIQoePIGgLPQKxujkgOhHplXyJ2csvgYLzl4Lzr9ouUL7YjqyLQ/axQblaGNLNfFfUxSeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from MW4PR03MB6428.namprd03.prod.outlook.com (2603:10b6:303:123::8)
 by CH3PR03MB7506.namprd03.prod.outlook.com (2603:10b6:610:19a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Mon, 16 Oct
 2023 13:30:03 +0000
Received: from MW4PR03MB6428.namprd03.prod.outlook.com
 ([fe80::831e:28d1:34dc:f518]) by MW4PR03MB6428.namprd03.prod.outlook.com
 ([fe80::831e:28d1:34dc:f518%5]) with mapi id 15.20.6863.032; Mon, 16 Oct 2023
 13:30:03 +0000
Date:   Mon, 16 Oct 2023 15:29:57 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Cc:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <jbeulich@suse.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v3] xen-pciback: Consider INTx disabled when MSI/MSI-X is
 enabled
Message-ID: <ZS061VoUzisTUEvu@macbook>
References: <20221118154931.1928298-1-marmarek@invisiblethingslab.com>
 <ZSz8xu8E9-02Ej8D@macbook>
 <ZS005ahNvQ/drB8I@mail-itl>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZS005ahNvQ/drB8I@mail-itl>
X-ClientProxiedBy: LO2P123CA0078.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::11) To MW4PR03MB6428.namprd03.prod.outlook.com
 (2603:10b6:303:123::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR03MB6428:EE_|CH3PR03MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ca748b-64f0-4f6b-17c9-08dbce4c00ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SeTl+BYVlftPBGjDIFVFl1ibNArylsIIr+dv4EI5d5cbrIuZEuaCF1Wqeu6jw00JQNFrfKP4l/viyRuPtTj0QEW/w+M1jyGw3vPW7E1bHsODkMiRm1sKhWPNjlVWMK+pjd8FFsla2QsBXyuoP6Bl15fjhqvqr/7EFUNYwG/ve3YESLPZvVG8RVTR4Zic72vt3wgfcK52HeOOY2JACbzGta0w+wxRdBB2tDD1gHiDYBlFrSLUuJBRi5D/ZsvJrN6dKPxnKieMM+xK+Vttuo3xA2tdepVLyelj3FHtokxHI3Yo+IW0xxACpJTOtJwJhbZGM0QeftNOb6x4/t4ryuHFxghZx6jId6go+W+5FnMEU4sBcWYR0UuZz+9Ost9W+n563VXJ3paM3yLTuHXGEBkOjaSCoEfaiN4Yhi7tAQcI7CBxTiin3WNYOinSR9ORlNDek3uiqD8VISdSjxmmRgQc5wkm7vBlS5wdEvCL3CAFpyw+X1ymmqZ5kSHcZCnAOo1WxA0jvltlPknnlKFVlupmjFXKcNDYFYa6FJSIUJBW+9Wp6AF8ar8UIIHh/Cvm6u/g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR03MB6428.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(396003)(366004)(39860400002)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(66946007)(66476007)(316002)(85182001)(6916009)(66556008)(54906003)(4326008)(8676002)(41300700001)(66574015)(8936002)(82960400001)(5660300002)(38100700002)(33716001)(9686003)(6512007)(2906002)(26005)(478600001)(6486002)(6666004)(86362001)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVJPd3k1MVhtV0RUMVZSUzU0cnd2S1FDVE5kMG1nR2dOVndWRmM0a0NlTG1t?=
 =?utf-8?B?Mzd6QU5WNmJMK0FsMFRUWjk3RllxRkZYVjQxa1Z3bFZCdS9INzd1YWhTaGI2?=
 =?utf-8?B?dHdjeFNHd1RrT0lMVDhwNmxhWjBOY1ZvYzRFZC9lRFNMOU5oRWhYSSticDM1?=
 =?utf-8?B?ZU9yZ3FKMkR4QmJITE81SitxQ2NDR1VmQ3lOVmIrREtHaldqMjJIcngyTTM2?=
 =?utf-8?B?ZnJDM3hYN3VHcVk2bDNESTQ3eTFUV3l0c0R0UGFJbGUxaCtoN1NicEZxRExr?=
 =?utf-8?B?d0VrZGFhL01mNklEV0FBY0NtenJGVmdGOGN0Tk1qRDJxL0hhWU1TazNGeS9s?=
 =?utf-8?B?SWt5cmFXV1NWSENCVnEzMXhXQ1BlUS9kandyOGlucmRpcGRsSE40K2NZdzR6?=
 =?utf-8?B?Q0w0dk5aOXpCN2xwS1R3RnNYazNvdjREQnhVanlwNnRmWnZvUzdjSDFCOWhY?=
 =?utf-8?B?U04xMlNESnB0TklFd0VBOGFMa3ZOOWxhQmlvU1U5T1BLK0ZjdFVIMWxBWUt3?=
 =?utf-8?B?U2pwY0dJTHJoSU5ESWtKemtLUlI1bnZLQzUreElSV2F6QnlWU0pMRWpVYmg0?=
 =?utf-8?B?K2duaVNjRVpRaERzNFl1eFNoL1FUVzV1SlQ1TUs3RjJlSEhNN3FEcHQzdkpI?=
 =?utf-8?B?clFEekI0TjJOQktYSnYzRlZxZ01PaXBibVN4OEY2dnp1TnZqVzRKQ1Z1cG82?=
 =?utf-8?B?VkkwYTl4ajRHQXl5YkxrbFNHa1ZIL3FTY0F5WThONkdFODIrNDVEYXpoSUdm?=
 =?utf-8?B?RHgveTlvakxESE5FTW9VaWdFSERHeU8wdTRnbEw2Y0lTaGllTkJKTkpxU2h3?=
 =?utf-8?B?Y1RWTzVBU3ZHdGZJMnhSbjJyS1dLSG1mMnBlRkZBNnR5UGsvMS80WjNNQXI1?=
 =?utf-8?B?SHdJY1BzTnhrYnhTZ0lZUGtoMWxOaXJKZ0l4UHYwV2FSOGpUb0pkaTRpNklp?=
 =?utf-8?B?anJxM0o0Y0VoeXVBV0lZWWpxTkNLWXNOUktYTHI1YUJKTnd1Y2grQUI5Smky?=
 =?utf-8?B?K1hOeS9VNWxWRUxqWXM1WVowMVZGNS9abUdEd3BjRzBkQUZ0WFUvRm1aNTJa?=
 =?utf-8?B?eGVFM0g1V01vVzZjcW9xaDZPSy9KSEZoWnI1eWJPRzNveXJZZDIvaEcvZzJD?=
 =?utf-8?B?WmhPNVFZeXRUK005R2t4cHBPV1R5U0l0OFFEWVJDWHJOWXdtakNBZDViUStR?=
 =?utf-8?B?WExiQ3Vrc2NSY3JIcW1xYnEyUzFoSlMvYTczRzJxZVkvVFJJK0REUU15T2xZ?=
 =?utf-8?B?dkQxaWQwQWxOd1FZK2MydFpSUm5lREtQTXZhVUpuNWY3dHBVMXJ5V3VuQ3Vp?=
 =?utf-8?B?dDBmMGgzUTdnZWZadm02ZDkzQ3dWS2tkSi9uaWFQUDZFSSs3WW9SWlloY2xv?=
 =?utf-8?B?dkRkQjNzdFhJbFE3R0hwR3loMklOM2hDc2RFdnBzWVNydVE1RUo5WHZtQ1Q2?=
 =?utf-8?B?dW1TUHJFV3hhYTg4RmZMVkxvK3BoRk04ZE5Tb3lTQUU4Yk1LSCtxSmtubEFN?=
 =?utf-8?B?elQ1YURmR0ZoemF6eDZTV3lnbkE3bDBLajdHbG4zcTA1SEhab0s0V20ydzd1?=
 =?utf-8?B?VmY2T1I1UDNhMGVMUEx3d092ZUlpRklVbll5cmV5eEtnUGU1RlZXRE11ZWdz?=
 =?utf-8?B?VUNIWVBKaU52Mk4vZkdyNU5GaWRTeUhiWVhlTzR6S1M0Q3lzTFZRVElHMERv?=
 =?utf-8?B?UHUwaFhXVXd0aUMyQnBJdG0zaTJwQzFSTjFBTEx1WFpGQ2VqMVIwQ0xEV1d4?=
 =?utf-8?B?ZDUwMGVSVkRmYWYvaDIxR05odTcxdzhmSE00NmFOZ3pWcVZqY0hHS0N4d1VW?=
 =?utf-8?B?UDlUdHk0d3E3VTl0VityUS9VcXNEa05yQkE0TmQxcm1RUCtkQmJuNXM5UTNE?=
 =?utf-8?B?STJXWk9JMyt0UFNUQm94aUc5NXM2YzM0dmw1UVF5MlgwTXVCZmdYRXhwQ0dG?=
 =?utf-8?B?VkxhbG83MTRkczhaT0ppL0dGT2xIWHNHMkdZWFlwbzdMQVpSRjRLOHdxbkFW?=
 =?utf-8?B?KzZiSzkrTWg2NXFyN0tjalFlOWxSdFdtOW05TXdKY1VhV3NZOUR1TzhsVTRX?=
 =?utf-8?B?VU1GRmpWUG5RYkYzMHNaQmd2R3kraXJBWW5Ydy83MEhJaksxV2tYbVpSOGg3?=
 =?utf-8?Q?Oi1HCZzLSMdoJ3QMGysOY4XCj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YjJ3UVNwNHBFSGJyTENXV2dZUjM0bktXYjF4VWtGQU90V01pTC9oWnNsbjdn?=
 =?utf-8?B?MU5uUlZxVjRwRTBCNUs1bUpNeWpWZ0srRCs2c0NHSzhmNjV3blZKbXlpUnlm?=
 =?utf-8?B?aDREVmdtTDRzUTRlZ1hERVkzdmF5cUlFbGJZT1VFOTRnZGhtVkNzbEFyY0oz?=
 =?utf-8?B?MnZkTW14eEpTQ3V3Ync3ZXhFSGdKY3ZOVmcvaFoyOUZGcDJ1MXpKWEpOTGZH?=
 =?utf-8?B?NTgvbnJybkw3NzlrOXpKa0R3RGZtWSt3NVBZdGVHL0NDelBnb0FWZGovZXZV?=
 =?utf-8?B?WHZxOTJsb3ZHYXNVSGpDSHl2WkFUUnVuVTF5NzQ4L3cyV0VBdjdrRDdNN1cx?=
 =?utf-8?B?MjIwVE54MC9ka2Q0Wm9jUDlRWGdzdHdJMk1scjJ1empoT05PNFZoSXBRa25B?=
 =?utf-8?B?TzdjaWMvSXlrczd0Nk5NN0FPZHZGRFh1MmRqMEVnbHNBYUVqbEkvd25qMElo?=
 =?utf-8?B?ZkZIOHdKekJVMGZWL3FXMXVHRkQvSDQvSzdNWGxoK3FIMGh3b2JOREdEdG1F?=
 =?utf-8?B?bjV0NUNLZFVrQ0RtalMvdjJGcVRTRkFiUStLRHBpdUtSeWNYa29KeDVKQktk?=
 =?utf-8?B?T09CaVBta05XUW1XbmhDVzBucjZaL2NPSVM0YkpVQUxpcC9OaktEMFhHcXlk?=
 =?utf-8?B?Vmk1cVNHQW93cEViMHBNaWpOeENEeFBTcEZhRlFCZ2NaZS9TM1BBcGRNeE1y?=
 =?utf-8?B?UDZSd3JxMm01eS9qRklBdGxRclVCWDFVbUZ0MnpCSUxad0dFQ1hENjdtK3pl?=
 =?utf-8?B?Qk1TekRaL1hMNWl3NmlPQ0g1RldqbzNlclVycmxzTktHNXBGL0M3WUNFUUlw?=
 =?utf-8?B?Q3A2S0doZEN2dmVSOTBvc2w0YVBlSzQ0L0VJcml4TmtZMDhBdldRc3BDUFhu?=
 =?utf-8?B?d2tsbWlzWlB2ZlVjczVaNngzNEdoa291ZkRIaWtlTGtNZ0R0VitzczY5azcr?=
 =?utf-8?B?NTBoSU9DaVFRbW5Hd0cxVDY0ajJuaEdLdTlQZnVsNzg1N2I5S2NsRmdKWkhQ?=
 =?utf-8?B?L1VTWEp6S0JnMjdhdmJtVTZwcENvQlFCNDdLVVQ1NFcrNS9pWnNYLzkxVDFv?=
 =?utf-8?B?Z2JqVitFZjE3c25zYmZxeWhCZVpZbkcvZXd5LzdoNm5IZ2xRTXpMQkVRUEV1?=
 =?utf-8?B?Y3RFMDFCRkppUWZ5cmhuUVpZTW9vY0R3L3pPV1ZoRHNmMFhUeTVLMjVJMmEr?=
 =?utf-8?B?QzZXNktjV2sza01kYzJXYzNudDJlbjdudjVNQUlYOGl0QUpYbVM5R2NLb0xT?=
 =?utf-8?B?VjhFZmY4QXBBcG90K2J0TlMvWEpkU1BDRC9FWVVqSXJZWUlpQT09?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ca748b-64f0-4f6b-17c9-08dbce4c00ce
X-MS-Exchange-CrossTenant-AuthSource: MW4PR03MB6428.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 13:30:03.3363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qNsIJFXaeXefS0bZCj2H1CiebDDOeOk11ES/Rjw8oFmAknx6TcKfBx7qTD5Iz/6XY2LljH2GYtWb+AEzdjGBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7506
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 03:04:36PM +0200, Marek Marczykowski-Górecki wrote:
> On Mon, Oct 16, 2023 at 11:05:10AM +0200, Roger Pau Monné wrote:
> > On Fri, Nov 18, 2022 at 04:49:23PM +0100, Marek Marczykowski-Górecki wrote:
> > > Linux enables MSI-X before disabling INTx, but keeps MSI-X masked until
> > > the table is filled. Then it disables INTx just before clearing MASKALL
> > > bit. Currently this approach is rejected by xen-pciback.
> > > According to the PCIe spec, device cannot use INTx when MSI/MSI-X is
> > > enabled (in other words: enabling MSI/MSI-X implicitly disables INTx).
> > > 
> > > Change the logic to consider INTx disabled if MSI/MSI-X is enabled. This
> > > applies to three places:
> > >  - checking currently enabled interrupts type,
> > >  - transition to MSI/MSI-X - where INTx would be implicitly disabled,
> > >  - clearing INTx disable bit - which can be allowed even if MSI/MSI-X is
> > >    enabled, as device should consider INTx disabled anyway in that case
> > 
> > Is this last point strictly needed?  From the description above it
> > seems Linux only cares about enabling MSI(-X) without the disable INTx
> > bit set.
> 
> I'm not sure, but it seems logical to have it symmetric.

I don't have a strong opinion, but I would rather err on the cautious
side and just leave it more strict unless explicitly required.

> > 
> > > 
> > > Fixes: 5e29500eba2a ("xen-pciback: Allow setting PCI_MSIX_FLAGS_MASKALL too")
> > > Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> > > ---
> > > Changes in v3:
> > >  - allow clearing INTx regardless of MSI/MSI-X state, to be consistent
> > >    with enabling MSI/MSI-X
> > > Changes in v2:
> > >  - restructure the patch to consider not only MASKALL bit, but enabling
> > >    MSI/MSI-X generally, without explicitly disabling INTx first
> > > ---
> > >  drivers/xen/xen-pciback/conf_space.c          | 19 +++++++++++------
> > >  .../xen/xen-pciback/conf_space_capability.c   |  3 ++-
> > >  drivers/xen/xen-pciback/conf_space_header.c   | 21 +++----------------
> > >  3 files changed, 18 insertions(+), 25 deletions(-)
> > > 
> > > diff --git a/drivers/xen/xen-pciback/conf_space.c b/drivers/xen/xen-pciback/conf_space.c
> > > index 059de92aea7d..d47eee6c5143 100644
> > > --- a/drivers/xen/xen-pciback/conf_space.c
> > > +++ b/drivers/xen/xen-pciback/conf_space.c
> > > @@ -288,12 +288,6 @@ int xen_pcibk_get_interrupt_type(struct pci_dev *dev)
> > >  	u16 val;
> > >  	int ret = 0;
> > >  
> > > -	err = pci_read_config_word(dev, PCI_COMMAND, &val);
> > > -	if (err)
> > > -		return err;
> > > -	if (!(val & PCI_COMMAND_INTX_DISABLE))
> > > -		ret |= INTERRUPT_TYPE_INTX;
> > > -
> > >  	/*
> > >  	 * Do not trust dev->msi(x)_enabled here, as enabling could be done
> > >  	 * bypassing the pci_*msi* functions, by the qemu.
> > > @@ -316,6 +310,19 @@ int xen_pcibk_get_interrupt_type(struct pci_dev *dev)
> > >  		if (val & PCI_MSIX_FLAGS_ENABLE)
> > >  			ret |= INTERRUPT_TYPE_MSIX;
> > >  	}
> > 
> > Since we are explicitly hiding INTx now, should we also do something
> > about MSI(X) being both enabled at the same time?  The spec states:
> > 
> > "System configuration software sets one of these bits to enable either
> > MSI or MSI-X, but never both simultaneously. Behavior is undefined if
> > both MSI and MSI-X are enabled simultaneously."
> > 
> > So finding both MSI and MSI-X enabled likely means something has gone
> > very wrong?  Likely to be done in a separate change, just realized
> > while looking at the patch context.
> 
> Pciback try to prevent such situation (that's exactly the point of
> checking the current interrupt type). But if you get into such situation
> somehow anyway (likely bypassing pciback), then pciback will still allow
> to disable one of them, so you can fix the situation (the enforcement of
> "only one type at the time" is done setting the enable bit, but you can still
> clear it).
> 
> If both MSI and MSI-X are enabled xen_pcibk_get_interrupt_type() will
> return both bits set.
> 
> > > +
> > > +	/*
> > > +	 * PCIe spec says device cannot use INTx if MSI/MSI-X is enabled,
> > > +	 * so check for INTx only when both are disabled.
> > > +	 */
> > > +	if (!ret) {
> > > +		err = pci_read_config_word(dev, PCI_COMMAND, &val);
> > > +		if (err)
> > > +			return err;
> > > +		if (!(val & PCI_COMMAND_INTX_DISABLE))
> > > +			ret |= INTERRUPT_TYPE_INTX;
> > > +	}
> > > +
> > >  	return ret ?: INTERRUPT_TYPE_NONE;
> > >  }
> > >  
> > > diff --git a/drivers/xen/xen-pciback/conf_space_capability.c b/drivers/xen/xen-pciback/conf_space_capability.c
> > > index 097316a74126..eb4c1af44f5c 100644
> > > --- a/drivers/xen/xen-pciback/conf_space_capability.c
> > > +++ b/drivers/xen/xen-pciback/conf_space_capability.c
> > > @@ -236,10 +236,11 @@ static int msi_msix_flags_write(struct pci_dev *dev, int offset, u16 new_value,
> > >  		return PCIBIOS_SET_FAILED;
> > >  
> > >  	if (new_value & field_config->enable_bit) {
> > > -		/* don't allow enabling together with other interrupt types */
> > > +		/* don't allow enabling together with other interrupt type */
> > 
> > This comment needs to be adjusted to note that we allow enabling while
> > INTx is not disabled in the command register, in order to please
> > Linuxes MSI(-X) startup sequence.
> 
> Ok.
> 
> > FWIW, another option would be to simply disable INTX here once MSI(-X)
> > is attempted to be enabled, won't that avoid having to modify
> > xen_pcibk_get_interrupt_type()?
> 
> I would rather avoid implicit changes to other bits, it may lead to hard
> to debug corner cases (in this case, for example, if domU decides to
> disable MSI-X later on, it would be left with INTx disabled too, so no
> interrupts at all).

I see, so a case where MSI(-X) setup fails and Linux simply disables
MSI(-X) without clearing INTx disable because it assumes the bit is
not set (because Linux hasn't set it).  Makes sense.

Thanks, Roger.
