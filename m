Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AB177A75C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjHMPXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjHMPXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:23:36 -0400
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EA3E54
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 08:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1691940217;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oJtfNphyH1ZmSnGEpDcUjMOlnuWPCn2dA98A/bnoTb4=;
  b=YdU4+NsYwlTR6YbeId5qANT6xhjKOiXJOFMpR1wdv7ysp/IUEuz/wLHR
   Hx6He66Nj7F4YJXWschuI1EayO1sksZY6C01RbN59ApVZREzN8Q+tBePZ
   3XD7DKZtIJluTYbYxjjMdGRMtMTayWl3Eicg3iLb3zr5t38yZEV3XHFTP
   Y=;
X-IronPort-RemoteIP: 104.47.73.176
X-IronPort-MID: 118037107
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:hNvPcK8fHiADyB4c/lwoDrUDcX+TJUtcMsCJ2f8bNWPcYEJGY0x3m
 2pKXGvVOquLY2OnLoh3Otzlp0wB6pOHytZmT1RrpSE8E34SpcT7XtnIdU2Y0wF+jCHgZBk+s
 5hBMImowOQcFCK0SsKFa+C5xZVE/fjUAOG6UKicYXoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqojUNUTNNwRcawr40Ird7ks21BjOkGlA5AdmNakQ5AW2e0Q9V/rzG4ngdxMUfaEMdgKKb
 76r5K20+Grf4yAsBruN+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+v9T2M4nQVVWk120c+VZk
 72hg3ASpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn9IBDJyCAWlvVbD09NqbDkl+z
 cMjFzQ0VSyevO+K8L6hdsdDuOQ8eZyD0IM34hmMzBn/JNN+HdXmfP+P4tVVmjAtmspJAPDSI
 dIDbiZiZwjBZBsJPUoLDJU5n6GjgXyXnz9w8QrJ4/ZopTeIilUujtABM/KMEjCObexTklyVu
 STt+GPhDwtBHNee1SCE4jSngeqncSbTAdtCTObnr6Y16LGV7jczVC03dXSDmNikuEWjWetvI
 F0p8TV7+MDe82TuFLERRSaQuHOYswQOc9tWHfcz5AyExuzT+QnxLmocST9EYtsrnMw7Xzon0
 hmOhdyBLSw/7pWWRGib+7PSqim9UQARLGkfdWoHQBED7t3Lvo4+lFTMQ8xlHarzicf6cRncy
 i6LoG4djq0XhMgj3qC3u1vAhlqEqYLEQQ01zgHWWH+14ARkYoKse42v7x7c9/koEWqCZlyIv
 XxBntfE6ukLVc2JjHbUH7tLG6y17fGYNjGamURoA5Qq6zWq/TikYJxU5zZ9YkxuN67oZAPUX
 aMagisJjLc7AZdgRfYfj16ZYyjy8ZXdKA==
IronPort-HdrOrdr: A9a23:m2EGUaj0ODhmHc6WSxs+NLSTnXBQXioji2hC6mlwRA09TyX5ra
 2TdZUgpHjJYVMqMk3I9uruBEDtex3hHNtOkOos1NSZLW3bUQmTTL2KhLGKq1Hd8m/Fh4xgPM
 9bGJSWY+eAaGSS4/ya3OG5eexQvOVu8sqT9JjjJ6EGd3AVV0lihT0JezpyCidNNW977QJSLu
 vn2iJAzQDQAEg/X4CAKVQuefPMnNHPnIKOW296O/Z2gDP+9Q9B8dTBYmOl4is=
X-Talos-CUID: 9a23:GQuR421jqWnEOn7dcNBrA7xfKvgaSULZ9UzsPnS1NVZlUoG7ZmGw5/Yx
X-Talos-MUID: 9a23:z6hmgQY0WNJh0OBT7B+wtBBCG/9RwrmcA10PqKUNqvSPKnkl
X-IronPort-AV: E=Sophos;i="6.01,170,1684814400"; 
   d="scan'208";a="118037107"
Received: from mail-mw2nam04lp2176.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.176])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Aug 2023 11:23:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9dau/5aG9vgmosWDl2Ek4MDC5ojh/hkEJ0cWuXP6kWUU3FtGmjcAOGDtLMpx3ATm7995bkNCLPnz4KE6Zjoy3ie7jGFElCsoLqjddAMasczG5SjwhXmG4eIWAIHfoNSPmYbLE7YEI6sbW3U1rlOS16gJCLj7EokYH/wYWpj8j7jmjVHY5Ti5g2dm4+JlzMOAuklywwmaekDcd1fIS6rwhAzsdUhFGHTVMfbdlapSQHGz9Tv5B6bVDDFevsPFBCOkQii1IuzLfIWoxM2io7+5wCL8jlSiUnyeoMRm2qd5t6OrpGE6gAkOnJZ2tgRCYQp4VVu13wGDyAmtA4vyoa6CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vwPOlk/DiUF/rN0Cg2AeYfC7EqZso4diCWEO21LYwE=;
 b=dBf3AO4JkndRM2FPkgepoAtf0ipIEefBZRZnZUzDp07KYNCdX6z0IVKAkOzXo1v3is8Sa1ASadns/kuIUbstoEdzn8VUh63DPUSRItFVvT1UVetCqH8w5zg5DDEp/MyJd9mm+o/3HzQhJn+UPkxkYpvCnJQ+1UIMP+j1MjhW6wZ98XQ+8VUHJiye/6RexigIC8ypgPQAUq08Nt855oorB/DroEzndrkUoZ/Rp50l2VQrD9i0fAf0cyUQJ0bpxa85LWO3VNZVMG8Qle1ve5NU6C4OzLlpcNIz5U5kyaqXh6JOo+qo8YbPC1YnkiX4NTLEH6y1dgNDeSkkGTAXw2HjNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vwPOlk/DiUF/rN0Cg2AeYfC7EqZso4diCWEO21LYwE=;
 b=u0dlPpl0+VCdzIoWCKg7uSvSepTXzL0GVXqeSQPQteQ9+wEIRSdNUTVf8I9L2lJpntyORillyupX1uYOq1oKvs1Hi4urac5Eodtnb7mnxDSxDNI4c3jo4Ww1vJxXeul06o2CLs9LE1orhdxE+PfIolebJv4J+aP1+JNs7H701jc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by MW4PR03MB6867.namprd03.prod.outlook.com (2603:10b6:303:1b7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Sun, 13 Aug
 2023 15:23:33 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::afa:50df:158a:a912]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::afa:50df:158a:a912%5]) with mapi id 15.20.6678.022; Sun, 13 Aug 2023
 15:23:33 +0000
Message-ID: <bd670c70-47f6-efc7-6ad2-cd833b414ec1@citrix.com>
Date:   Sun, 13 Aug 2023 16:23:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Andrew.Cooper3@citrix.com
Subject: Re: [RFC][PATCH 12/17] x86/cpu: Rename original retbleed return thunk
Content-Language: en-GB
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        gregkh@linuxfoundation.org
References: <20230809071218.000335006@infradead.org>
 <20230809072201.259675763@infradead.org>
 <20230809142031.jkj4pa2mhccrdmmd@treble>
 <20230809142255.GQ212435@hirez.programming.kicks-ass.net>
 <c4c1c9b8-9ced-7282-718e-48e14375e9f1@citrix.com>
 <20230810130229.GA212435@hirez.programming.kicks-ass.net>
In-Reply-To: <20230810130229.GA212435@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0122.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::15) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|MW4PR03MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 0551a0bc-5ba3-4571-db1f-08db9c114128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AJJ0HkhMGnrxvA302ri0pEBDlcVRZiu0vzsNejKUQGMP2TSs9CdfDrq3+DCP+l1EwxXj/2rzSZVDENcYTAZml+UAwSByFt2jRhXDkTaKuIt5xC2fVJVUzxis6G72K60T0uCBQ9NMbzCFFj4JccNdNtlj6wlOxIgP3MwFZIiXTPwlAu7vPcdB4WWwpS61/r3Q5hvnP9qVDa1cyjgmWr7Kgj3CfAuBGOJZ6J+T5o2ACvXI2xT36WHWIEwIryf/t0/Q9fIJhHZQusk7R0XlY/pYEUBlHJxV++V9YWeRA+BPOKfNn+wrRwhfkfitH03ozn7AuZJY5PzgGgz969i2ORn0TnjVO32/nqudJ0dTeXlTPFSXTSm8F9M3I/uXSXdZl3oP+TsW7wLdlL0kydyVZlXqOhwbb9cA/Y8VrhDAJg31vkJBRmNO9CJSe4JQk+p4jrRImUFspbW5OKDRZhFov4l1EZ1eUr1aFkQKy0FfhTtP3eqRTjpIwOUEM4gDHdlVSCPqfhRwTTUkSzbRP9btFnWMwMFxU+PtNSF3D159zTSiA8fTOpcJJMYUWiHXuUCabHSJsn2ZmCYCqb1HmaZ4Y/aBCYUeuMK58Mjb6HryIcpV9Xc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199021)(186006)(1800799006)(66574015)(66899021)(2906002)(6666004)(6506007)(6486002)(53546011)(2616005)(31696002)(26005)(86362001)(966005)(6512007)(316002)(6916009)(66476007)(66556008)(66946007)(478600001)(38100700002)(41300700001)(82960400001)(9686003)(5660300002)(4326008)(8936002)(8676002)(36756003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmRTMHlhTnhSRnlGbHE1MXlTSDk2N0M5bzVBcGtVVXlLNjhpMFFXbEd3WDJq?=
 =?utf-8?B?Q0gzU2xOd3oyRi9GVTMzcE02Z0VSWlBtckdHOTdubSszdDFYZE9zQWxCaW8w?=
 =?utf-8?B?TTVEYUhreVFIa2lFM3EwbkRiMGlwRTRvckVtSHNCMGZVajdIZ2NrNS90Zk1r?=
 =?utf-8?B?RGlWVWFDaWNiWkg3STQyanU3RmI1NnJlbDViREJUck1YT05JM08wdEk4THJy?=
 =?utf-8?B?b2F3U1V2Ulk2V04ybEZES1U4RGJhL3U5dmx0Q2cwYWxyeCswZCtOUXhGNG9V?=
 =?utf-8?B?Qlo3K1F6STF6Z0ovOEQ1cGpTOGFvNm95N0FjQ2pJZzYxY05kR25ERUFyRDgz?=
 =?utf-8?B?QVJkbVBCczFSYjE3cUlJN0N1dmdKY2dUeWJnUkkvOElCbCs4N3QzRGdxZ1ZG?=
 =?utf-8?B?STBQMEgwVXN1OGptbVFFS25oRHovdkNpeEtoMUdYNGFLbkxpUzFpOW5jUGJ0?=
 =?utf-8?B?bUhyb1dITG5hTjJobjg5emxOeldtck4yYVpkekw2YnJCSnlFQUJMVkZQUUR5?=
 =?utf-8?B?WHRFZWswclFKb3luUnFKQ2hBOG0zQmJsSk1jMjhKOXhyQ3E5cHFUWnR4NU54?=
 =?utf-8?B?cEFRdUF5bXYrSFVxM2tORFJGc1ExeDNrU0dlL1JBQmVrQVRVNjVLZGJzbjVa?=
 =?utf-8?B?R1hPMjNjdFBUalQ1RG54WEFoRmx3aVVNbWE3ejZmb2w4UjcxdW5pbTBjSFRP?=
 =?utf-8?B?VXN3aERrZ3czTHBXTndkSjB0U3BRajQvSnZyZHFsR1FsQmRHYUtwNGNieFAy?=
 =?utf-8?B?RFFvQzlZV0YvUHFyZmpVdWE4M0l4ei93L2V0NnBPSzI2RlZwUGlwZ1V5YjJF?=
 =?utf-8?B?QTNLTmUvWUQwaE1BUWlUS3J5NHFPRTZNVERiREtiU1NkSm9qajMwZmdhY3pq?=
 =?utf-8?B?dndyb3c4czcvbzBjSUZNVXd4NHh5QTNPVzQ4c0E5cDJOcGFPUkdyTDJWandC?=
 =?utf-8?B?UDdDai9RcmtDQWViQmdINUFxQkZtRGd4UGUwTHV1bGM1M2QwNldyOXZTNnJ2?=
 =?utf-8?B?VStDNCtWaEY5MnBZdTRzZVNFZXhSMFBaRnh4TWNXTlZwazhOb0FvT3ZidHNI?=
 =?utf-8?B?R3hOUnJLcVZFNkN3cklNZjNzQUVrLzdkbGlsL3ZMVDVnK2ZrRVQ2bklFRDMv?=
 =?utf-8?B?M2hLNUhtNW1tdVo3TnVxeG9leEV1RytlT2NlY21jazhvMUN6bURjNjFzUFV0?=
 =?utf-8?B?K0tiRmx6LzVTNVhUVmx2NlZpTXFTYXNDR0hzVlV1N05HMVRXaWl4M25LNmtl?=
 =?utf-8?B?dWM3V0YzUVNjc2V0NHpCbUxnQVJ2K2loYkI2OEJ6czNXWWV0TGJBRVJ0RkxX?=
 =?utf-8?B?Mzh4bVdmSmZ4SlNra2Q3bm9mNDNhMm1ueUUyNlR5Vkp5Y2RZRVZGTWJWYTJI?=
 =?utf-8?B?RXVmY1hQWHBmTUVpMEdyUEh5Zmt5di8wS0dHYjByQVN5czJHc3pYc1pDTjRu?=
 =?utf-8?B?a3FvZjdteGVUK01yM21UVDVOWHVTWW9RNExoQTBaUm9jVjFLZkdENFRPaG80?=
 =?utf-8?B?SDNMOFFsUnRGdEdrUkIwbVA4VzFiSlBiSm4vcERXWlNLcVFaSERTeTg2QVVT?=
 =?utf-8?B?Y08waHROYnBYR2dhcjZZN0hlT2hWR3d4ZHE0bStndjU1QTVBM0lGYldRTjJv?=
 =?utf-8?B?a25paGNpYkxweEZReUVRaFlHN2htbTRCRmp0NWE2V0RlUTlJQUdCcmgxWGtr?=
 =?utf-8?B?TC9KV1JZMUhnMGtwWjJsaWxBU2sxS1E3YkoyTUVzRHdHSDNoTldBdVJNamFu?=
 =?utf-8?B?SDd6R2FjVUVlTG1Za3I1Mm5SalFZU0EyMjY0QlA1SnVTMEU5TnRqMXUvalh4?=
 =?utf-8?B?bEx4VDJyQk5BZHVNNmlnTHRpWEdnTWJseFRTbzFhbVdNUG84SEN5ckgyL0pH?=
 =?utf-8?B?RFJGd0VJaU1uQlpieUlYWUJxUXBwRTVFd1hyYmRGT3VwbTV4V1lkZTJtd0RD?=
 =?utf-8?B?Rkw4U20yNVdXMjIxL3cvN2syUEJVR09qRmRCUFhjaDJCZ2p5V2ZoNUtZSWRo?=
 =?utf-8?B?WTBlWk84VTNBMmlvbmNBUi8xTThGbWIvUkc4L0huZUFvMXR0Rmh0Q0hOdE1K?=
 =?utf-8?B?MU94d0hmNnkyTWRsbGdhbG1IeEk0eGRseGpFNGVSWjBXc3BzdlZUWWZZb1lY?=
 =?utf-8?B?U1YxUmoxOWlxcmovSHMySmRueUw5YTluc294eGJ4S2ZQSWIrTVlYNFB6THli?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: z2V3elbazVbWOpBkmxrsG5mYo6FEQjzCKyko6810SwF/w+Adu7bElBoxUwxpGe2Q4a1+S5R5yc6OJNfnGRH9uaVzf9oRhibE8EfII5Vdw7xgirRGzP+ryOyu1S8/OLQR4MicxClOkcXtSqxwM6cboFF09UFYnFwxsubCTupjx53CFFbQrHDbVCp2bXi254SYqJW2kR/f0EtwRO96pVdAg9/Ltw23KNiR1lzis7x4xY4qZm75uOi3xwMHikjjHk59EHNpZPCgmJKNjx77z/zMpf2VPBE4VRejxyJ7H2w78S18wUgoWDPi7vYJma07TC9T8raYUZd1o7irqKN+ze4SLWRD3yR2YTotG5pqC6uxZBGk6YZ+wYfmw4vW78D0IJ4uca/gWmuOmpiXP9Hd0h3kWxi5gh89oTYkDNel0exLK4SBt5oo7ilPVXpAZb6Ndink2QLUHAd3UvA7gNP66iGIK+HbH+R+lDseZik8Spx3YVnLsFsB3mV3NBJxmcNVkeJ7lugCHJZWO76NaaAb1OY7M/+GEZ4P58t6ZBQv0rIAuTvBbNUSTUdf4q9g/r4NmPKkVr3bhG71uvJXIt9+PLmY6tNz+XH3M2SiQnFRDTGj+X5xNRUFPiVGGFQfdxEEteP2j0bKI1tir0nIfPk0qU56frIdmsPXkoJ15Y2IgaltSLC9zXRl0RrOV7TL1agYT0JIkYO2jlMNTs3UbjdnPWceoRP1BYt/+SIM7y38D8ucXz4zEz4ahkeMsUMhV+987uOMa9n0KRYGxwqBGBE62TkValgYcGVoYjrFKbV6TuI3fG7p63RzLNFta5H9cXtM54IEnA0lGYI83tQDYVdANcnqkloRk3nnDuCyQYv1rjyQz+zcO8dfwQe7+HkUB+4UsKpMe79Ed5DEVoHjXigAgDrcsA==
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0551a0bc-5ba3-4571-db1f-08db9c114128
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2023 15:23:32.7990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNo5leRxa/M6BKt8LEVEuAkz8f5FwzX0/lP2YGLUCjFzp7wJhUwu/a1xIBkXr43FZq1FUKD1EkgRQolSvOiE1ZjRfjU8pGRys5jXWTWJsp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6867
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 2:02 pm, Peter Zijlstra wrote:
> On Thu, Aug 10, 2023 at 12:06:17PM +0100, Andrew.Cooper3@citrix.com wrote:
>> On 09/08/2023 3:22 pm, Peter Zijlstra wrote:
>>> On Wed, Aug 09, 2023 at 10:20:31AM -0400, Josh Poimboeuf wrote:
>>>> On Wed, Aug 09, 2023 at 09:12:30AM +0200, Peter Zijlstra wrote:
>>>>> +++ b/tools/objtool/check.c
>>>>> @@ -455,7 +455,12 @@ static int decode_instructions(struct ob
>>>>>  				return -1;
>>>>>  			}
>>>>>  
>>>>> -			if (func->return_thunk || !strcmp(func->name, "srso_safe_ret") || func->alias != func)
>>>>> +			/*
>>>>> +			 * Both zen_return_thunk() and srso_safe_ret() are embedded inside
>>>>> +			 * another instruction and objtool doesn't grok that. Skip validating them.
>>>>> +			 */
>>>>> +			if (!strcmp(func->name, "zen_return_thunk") ||
>>>>> +			    !strcmp(func->name, "srso_safe_ret") || func->alias != func)
>>>> Hm, speaking of renaming they should probably be called
>>>> retbleed_return_thunk() and srso_return_thunk().
>>> Yes, clearly naming is better in daylight. Let me regex that.
>> btc_*, not retbleed_*.
>>
>> That way it matches the terminology you'll find in the AMD whitepaper
>> about what's going on, and there's already an entirely different issue
>> called Retbleed.
> So BTC as a whole is the fact that AMD predicts the type of an
> instruction and then picks a predictor to predict the target of that
> instruction, no?

No.

"Branch Type Confusion" is the technical name AMD gave last year's
issue.  Hence the name of the whitepaper about it,
https://www.amd.com/system/files/documents/technical-guidance-for-mitigating-branch-type-confusion.pdf

Each of these issues has been given a technical name given by one of the
vendors.  Spectre-v1 was Bounds Check Bypass, Spectre-v2 was Branch
Target Injection, etc.  We can debate at some other point whether the
names are ideal or not, but the point is that these are the names that
cross-reference with the vendor documentation.

The naming scheme either needs to be BTC+SRSO (AMD's names), *or*
Retbleed+Inception (EthZ's names, remembering that Retbleed is still
ambiguous), but not a mix of the two.

~Andrew
