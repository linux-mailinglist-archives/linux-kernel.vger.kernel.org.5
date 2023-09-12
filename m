Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902F579D39D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbjILO37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbjILO3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:29:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23520115;
        Tue, 12 Sep 2023 07:29:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C9nEgk000621;
        Tue, 12 Sep 2023 14:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=HEsDhzp8+cOaayGvrQiysZ4eHiagqo4dCpJYdp+bBN0=;
 b=T1htrV7a5V5MXotuX6CXri/Q9470LKUTrq69knL+sd9QlTDVKnEUqB1eHHzyGEjAVKDL
 mWaUEmE4yfrvCuPe2jflkqxs4X4SM9U5PmUpPBskS9yQBMkbg8pR0wiLerRZtw73Izr4
 RLcuxQqspxYhtuK1JzlYoM7oG/SV0/H5PdtXMFzwXxJsk5JHY0W98W+iA3Sp0x2Tiu3Z
 4WlBvhL9XPMCUBgeQPcBfWWNFh3OP8A9QfJ6EsF7aRCRLgdY5brJskb1J3YuxOJgI40C
 ehUEt30ca7EjeFq9i6XML1EyO81vgvuAE8n4lAuOVF8DeUSwl4dOBut+EwdMB5XbuktH rA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1k4cc34x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 14:29:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38CE52gw002861;
        Tue, 12 Sep 2023 14:29:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5c3708-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 14:29:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaCaPL2yJKLYWqvTsMkN7uAE49h+1aF58Fn+P8Qnt5RvNDQlXhZaQwiZJiPDUYm//YATvomHrx86og5dwEPovfRwMyzZ0C/8bvoMseIubMCCXFO4lp5xDwZDv1aOgO5dJ0nB6DInDFenRrgo/87VkekC482kY7don1hvms+YfRKf72puynShtZcLPHqDDWYUL0KGqtBwIMTVDIdw+J6+fJZq2bmckVY8aAvPZ4e+wQoMxIpu2D2ycRGX1V4xhu5xft8Z8z7rBfHTeT96tZFSmM7jzWCPrKxsyXN2EsmheWD3ZIsPajcDaLuJ04GxmSjR368cIBGNQ+bEDRBunzncTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEsDhzp8+cOaayGvrQiysZ4eHiagqo4dCpJYdp+bBN0=;
 b=QFuOQRrH1X8Xsoz2F+VDlLGXJQGUYSfoeyLWspy0WZ50CuxX4X2GycbioR6RBSZO9u30Y5H9umPRTm5IzRrvZ47KTJWryRCj+PlRfLZVofhFVDxV6qzE+BAj4HnkQMDrztWVi09zypfCkPzPtlCUPVTRSDnULmpPIeVJPYAzuDdbw2/zwoK7BcVdP4Bvxz94k04QfWpN3tHsTtuzU1K0tMgKgFRN4qrQzNNONVY61uCmlBx76W0ehNwiva7y0EBk+Z2fh9ym9AExShOeicYp8qR6aCaXFCzApllxojIakMwHweKsYKvbYkdeNzdHSNIifb6X7C57sELv8Bi9Choawg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEsDhzp8+cOaayGvrQiysZ4eHiagqo4dCpJYdp+bBN0=;
 b=L2InKCskfTKn8bRsLEGFyxMudmQWSaRMKrRfkPAWi/DRTZofHHu9cSkCuoG5eSuceSqwKtf1jsWr7OHFWz4mFcDrR+A+XPCwz8Lnxi6SvWoyHu7DExeplA7dfegcVrZJ/P4BMV6hKA+hAVLTO7VVQSWT324cRHNMgyGN+3iyl0Q=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4616.namprd10.prod.outlook.com (2603:10b6:510:34::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 14:29:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 14:29:33 +0000
Date:   Tue, 12 Sep 2023 10:29:30 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
Message-ID: <20230912142930.xdautl7cabb67nap@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
References: <ad298077-fca8-437e-b9e3-66e31424afb1@paulmck-laptop>
 <20230906172954.oq4vogeuco25zam7@revolver>
 <495849d6-1dc6-4f38-bce7-23c50df3a99f@paulmck-laptop>
 <20230911235452.xhtnt7ply7ayr53x@revolver>
 <33150b55-970c-4607-9015-af0e50e4112d@paulmck-laptop>
 <CAMuHMdWKwdxjRf031aD=Ko7vRdvFW-OR48QAc=ZFy=FP_LNAoA@mail.gmail.com>
 <f9b0a88c-8a64-439f-a488-85d500c9f2aa@paulmck-laptop>
 <CAMuHMdX89u6wL9W+8ZOn-OTT1FreYjEqYnvEip4Aq3k1gOP0EQ@mail.gmail.com>
 <62936d98-6353-486e-8535-86c9f90bc7f4@paulmck-laptop>
 <20230912135617.dnhyk4h5c555l2yg@revolver>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230912135617.dnhyk4h5c555l2yg@revolver>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0428.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::20) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4616:EE_
X-MS-Office365-Filtering-Correlation-Id: d438aa0e-aa42-4b81-bba2-08dbb39caf1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WFq51A56XTJEqEwqcnkCSPXAGLLRl+rwLICwH6ZzI+vsskS8Xd7n4TkCNYVgMwPjF/tNAlH6yDYOdm8UneewplHLwnWr/T+elX8dOg0rZgrzY99dAmw4PSJckRYEV6uf5rX71ZACn/hRoS3AyD9NS+i8CKravUy9iomC2i5jGpXzpfKpAygDtCzfx0zSJdaRqqWwETCCsAm9ABt06T/Wukv+WQXcXppZjPMeVUjYhsZT2ul4V0krDjaqT7sQdH5S3RkiPu9CAW8BDh12WunAW/MUXhaqjvyGDyI37t1C5qs80NdNjoldTTvvpriyimx+nOhQubIqb+3//dXD/SOonyWtNOt0GpCdWL+5vkdVWphU+R+SkrAvFsp8z+HSvzxcPr3Ojo5gLWkYjLq1ITVhqSYmqZ7O2qPXWjRBZ2sqIwQToYh5ooLImZFIBrDmwGt0i9v4mcXhuQKREq6mvkpyWcxwdhekqN3o3ulq4Wb2134bUz97lqyxDP3yzN0S065l5Y+ArP9GqmzCjoCoUOKVn+R6JW+sWgsbHfMcL6B0/Bmj94MdU5ChxHAwxP8kWawq/co389JMpH2m6cX4MX6l3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199024)(1800799009)(186009)(33716001)(6506007)(6486002)(9686003)(6512007)(53546011)(966005)(66946007)(66556008)(66476007)(110136005)(478600001)(86362001)(38100700002)(1076003)(26005)(83380400001)(8676002)(8936002)(5660300002)(316002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q00yUW9jVm1rZ3ZSbXU0bWxlMEx5NHdqblpoV21wd1kyRElkbnpOV3lleitK?=
 =?utf-8?B?bFZPMVJkNW5YamFtajhHZjNlcCtQZ2JJc29UZnpmYmEweXllOGYzSnc1ZUpm?=
 =?utf-8?B?THM1dnQ5Vi9TNGp0bzRIZU9Fbi9JUndnYTNhaFRMUG5nQzB1MG42V1BuVjdM?=
 =?utf-8?B?Y09qbXU2S3Vjb3lzVTcyQlJaako3YkJlMXdBSFZDa3M4Q09SSERseFlmT3Az?=
 =?utf-8?B?NC9VL1hyeG5CNHI2aEh2dW94YSsvdEc5T3VwVjJqVjlLMVJRYklPM2VxaXYv?=
 =?utf-8?B?RDlBTFhuRXVuLzlRNUxTdjkzb1c5Rm85c3RxU2VlcGYrL0dGQU5YcWU0azBI?=
 =?utf-8?B?c0oyTXNHRWRORjNjLzVpOVBaTHVId1hlQkRibHZvTHhpNjJYdkxoWWJuZTVF?=
 =?utf-8?B?aGFvUTYzQy9OTEViam5SdlNmUzZQanZ0bDIva2tyN1cyeVcxbkJnT2RuVEEx?=
 =?utf-8?B?YnVGbGlEU2UzMjdIZUlLNnhENFVpcDE5SThrY3lDTkFrUmlNbVhGU0FOcS94?=
 =?utf-8?B?cVVRVGFpNXRDZHNKcnNGdUw3RTdiWVF5YUFCb3VIT0x6cmlFSWVCSC8vYlRQ?=
 =?utf-8?B?ODhvaWVnOEEzL3FIQnNZeEV2cjlUTko1S2VDV0c4UENDZndQQ1dMVmNpa2NW?=
 =?utf-8?B?bGFDYWF1QXk1a0RvRHlIUnpTNkVSMjFhWVlYYVZqbG1PdU9Hdis2QlQxTzZu?=
 =?utf-8?B?dFU1WDA0dTh5NjkrUU1jME5oL3pjL1UzdTJ3ZmVyTHZTUCtYeTc0eEh6clVl?=
 =?utf-8?B?b2R5MGNYdENHeGJnUzVycUZVdk1EQlVLcEwrWjRuNWlBSWEwZ0tYZmpkOTBO?=
 =?utf-8?B?WTFITkRvVnlnT2grY1kvNGFxYTFoaFVDTGR5MEVkR3ZZcjdoZzFkVWxUbFhY?=
 =?utf-8?B?b2dpd1J0VXA3bCtVcnBtczZKTm9NemJKeTFHWVJFZkl0SlB0aStMMlR4aFN4?=
 =?utf-8?B?WG1DMk8rMUFuUHBpRmM2ZEJPU1NDaGVUWUhxZ0o4TXNPWUxyamd3aWJRSzhu?=
 =?utf-8?B?WENXSlBJRXY2UG1tMy9YdGg5Q2FMYmVnd3pBZTFjMktkMERrMm14R2lMQkdP?=
 =?utf-8?B?SXFiY3FMdG1hRk9XN3JOb1VjVHRGeFUrSWJaV1Jnd1pqakxYSHdwQWxOSVVu?=
 =?utf-8?B?TEp3UjhCeHNxU0dUbTVRbFBUNlY4bFZ3U2xzcDF4OUVzbC9meWVFbEJ0YzV0?=
 =?utf-8?B?NVQxb3VVMGYwUU5ZVG1kTkd1YWNqZXBVcG85eklJeDRYMDJ4WlMwU25qb3ND?=
 =?utf-8?B?bDA0MFZIOFRGd01jdTFtWFpPVVFQWVh2TVlKODBPdTgvQkhwUmZMOVZFYnE5?=
 =?utf-8?B?ZzZjanhGZ3plL1dQanYyNG54cjNSNm1xSFRlRE81Y3lxWUx6OUJMbjduQlJK?=
 =?utf-8?B?YXc2NlY4NlhtVmEzQnhWTmpLNW1Vc3YrMTJqQUNpVW5SOWk4VmtJUlY4OS9h?=
 =?utf-8?B?RHpXK3NNa1F1KzNRdlVGT1d6MU1rSTgveU1HOUhmNDFscGNtMTZaNGxKRlBz?=
 =?utf-8?B?cm1RWDFsS3FmOTZLN1NwcVY5M0JQVndEeThBNStFdFdyR2JvT0YwYXNpWnh1?=
 =?utf-8?B?RUFWS09NK0N2UjlQaEhiUFlUcHdPRG16emVzampaZDdKL0V5cVJoVmV6ZWk1?=
 =?utf-8?B?Mm1WMmV2a0c4NVA3TWhDSkx5bktXdnVPVzlhRlduK3ZJRlV5QUVGUEMyZmdm?=
 =?utf-8?B?N3VpYloxY1dSMzlKVU44RGdET05CUXBlb0VwNmxhdW9pZFUvVkJUYm5hbHkx?=
 =?utf-8?B?dXd3c00ybkx3SXlLaU1xTUF0MElON1I2RTNPY096QXAzZTVvQkpObit5bmdM?=
 =?utf-8?B?VzFLUk9vQ2VPVmZpRkVOaUduTVhrdHJCT0VnYWlqQXIvbWUyZDhsTzY2ZUc4?=
 =?utf-8?B?dE50NEkvWmJBTWMzemJJMisvdEI4QzRrR2NYRXVsbXNRbE9CU0lrdnJvTnh0?=
 =?utf-8?B?aTNWc2U2eVEwMHJBbjZtd0wrN0xreEdyRStKc0dXVHlzbHI5YUVCeTdnWUFK?=
 =?utf-8?B?TW5BRkxEd1p3KzRnUkRmZXZOMklWT2VKU2lCWE43Y1g0aHJOVXZ1UGtVSkRY?=
 =?utf-8?B?amREL0l4a0ZqcVNwUWJBSngraThyMG9XQmdtSGptY0tqWWN0eW9CNHhuYVFk?=
 =?utf-8?B?NjIzK3oyMVQ1R3paYTh5SDM5MHZoMmlOMG9seFU4QlRLaVVQRjZWcEgrbkMx?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?amtib1QvcWxuYWhhb0t6akVYMXVtVE1uRW5ONGZNaGZIdVVYeTdFei9mZHor?=
 =?utf-8?B?Ym1LeWtZZnVvQkNGOHRjYkVzZzBqU3NzVDJHU3VteFRybFpiZUhOZEdqSFk0?=
 =?utf-8?B?c1hiSTl2cDBqV0VBY05paldYaDc2V3BKVVVyVHF0dXZ0RzE5Y1BoM1RXbFpH?=
 =?utf-8?B?anhDMUNqSHdTa3VCR2txZ05LWjB1bStVWkVGVjlMV2hHZTZiVGZGcDNiMDVL?=
 =?utf-8?B?Ykw5eGYrVVNEb24xU1RIOGtkbVNmRS9hM01DQjIzWHpmYVBJNDl1RENSQ2Na?=
 =?utf-8?B?eURHRzNWQmJIL0h2QXZ2RkNvRVZTcE9YQ254cXVlOHM2TVYvTklQV1BISjU3?=
 =?utf-8?B?VWQxaTNjdm5MbHRlOWdUTWR0YWZWV1NXckRnM2dwdDhhY3FuVnJrWGxiRzhs?=
 =?utf-8?B?ZW5JblhsQVNUd0txTE4xLzIyLzdHT3FycHIrYUlsbU1TQ2lGRUdCb2s3VFc5?=
 =?utf-8?B?OVBvbXQ1eUEyM0xqSXgvRCtPdDRTL2F4K1FORktBMDMza2djZkFtL2MxdTRr?=
 =?utf-8?B?ai9sK1JjaU9FZys4R21FRWh0M0VUUk81RTFkTjBiN1BXQ25IN0FsdUNsUTlu?=
 =?utf-8?B?d0VxeDZGUUY1VnVnUE9xVmIvU1pMWUdSRVZzcUYzRVgvQWpkRGdKeGx5Um9K?=
 =?utf-8?B?VXFLcXhidkIvbDhCUGF4RjlUcnMzVXg0bEVKQ2Y1ZHVBbHU5cG9adVEyaUFH?=
 =?utf-8?B?SGlsOXRaN0xNSHduQzJyblJnRzI1cHkrVXRkL3lmK3VwaDhaSFpCNFFBUFE3?=
 =?utf-8?B?U0QrS2gvbWQwbDRpWTRpOEU5QUVRWXR3ZkJrNURJci9sM1VObE56LzZvS0pv?=
 =?utf-8?B?OWhNWGJNdzI5RFhzV3liTEUxcDFsRkYvV216bGt1Q2UxVysrNWRZcldMS2Y2?=
 =?utf-8?B?THVLVTJteWFYRmh1bldTLytHQzBtSTU0a1FNWFJITUw1THYrajJ4ci8wcTVw?=
 =?utf-8?B?MG0wQ3l1S2tkdHJFMDQ3alkyTjZsaWp5czJiZmJERks2WVVzOUMzV1Y3ckJp?=
 =?utf-8?B?SWV2Umo4TFVyYWg5UVVha0dzWiswYnBFT3NzYnFwRklTb01rd09xRWE5ZHR6?=
 =?utf-8?B?WFpzZG5TOTIwSmlmVlpha3piNEVtMUliT0t0Z2ZxL2gxV0ZsWTV0U3g0dFVC?=
 =?utf-8?B?alpDOW9HSG1ObFFvZVI3M0NSVENDdWF5SjNINTZHeVhzeFNlc3JNcW14Lzc3?=
 =?utf-8?B?M3Bob2NDbkF1bys0ZTdRMzBlcHZPR0FTby9aWW1idkJURHZNeUlQb1pYWXNY?=
 =?utf-8?B?bUpld0gwWkhUYUI0OXhsTTdtWjZGejNvY24yQXIvdnVPL2t2RERoMHVBbWhJ?=
 =?utf-8?Q?Umr3BzLvE8h5Htg75YvxDZyoSeCsHTISAo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d438aa0e-aa42-4b81-bba2-08dbb39caf1e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 14:29:33.8330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmNRlACHa2GH3p1KowRmTe/lUE0M2Q9DPi/HrnEFFHR+wCOKLCchkZFZ+EiaI8Hd4JLizbi5B+OjdhmtQL6Ndg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309120121
X-Proofpoint-GUID: 7BfrYqpJhi25nO4Yl4CuwPLcNYUeHPMD
X-Proofpoint-ORIG-GUID: 7BfrYqpJhi25nO4Yl4CuwPLcNYUeHPMD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [230912 09:56]:
> * Paul E. McKenney <paulmck@kernel.org> [230912 06:00]:
> > On Tue, Sep 12, 2023 at 10:34:44AM +0200, Geert Uytterhoeven wrote:
> > > Hi Paul,
> > >=20
> > > On Tue, Sep 12, 2023 at 10:30=E2=80=AFAM Paul E. McKenney <paulmck@ke=
rnel.org> wrote:
> > > > On Tue, Sep 12, 2023 at 10:23:37AM +0200, Geert Uytterhoeven wrote:
> > > > > On Tue, Sep 12, 2023 at 10:14=E2=80=AFAM Paul E. McKenney <paulmc=
k@kernel.org> wrote:
> > > > > > On Mon, Sep 11, 2023 at 07:54:52PM -0400, Liam R. Howlett wrote=
:
> > > > > > > * Paul E. McKenney <paulmck@kernel.org> [230906 14:03]:
> > > > > > > > On Wed, Sep 06, 2023 at 01:29:54PM -0400, Liam R. Howlett w=
rote:
> > > > > > > > > * Paul E. McKenney <paulmck@kernel.org> [230906 13:24]:
> > > > > > > > > > On Wed, Sep 06, 2023 at 11:23:25AM -0400, Liam R. Howle=
tt wrote:
> > > > > > > > > > > (Adding Paul & Shanker to Cc list.. please see below =
for why)
> > > > > > > > > > >
> > > > > > > > > > > Apologies on the late response, I was away and have b=
een struggling to
> > > > > > > > > > > get a working PPC32 test environment.
> > > > > > > > > > >
> > > > > > > > > > > * Geert Uytterhoeven <geert@linux-m68k.org> [230829 1=
2:42]:
> > > > > > > > > > > >     Hi Liam,
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, 18 Aug 2023, Liam R. Howlett wrote:
> > > > > > > > > > > > > The current implementation of append may cause du=
plicate data and/or
> > > > > > > > > > > > > incorrect ranges to be returned to a reader durin=
g an update.  Although
> > > > > > > > > > > > > this has not been reported or seen, disable the a=
ppend write operation
> > > > > > > > > > > > > while the tree is in rcu mode out of an abundance=
 of caution.
> > > > > > > > > > >
> > > > > > > > > > > ...
> > > > > > > > > > > > >
> > > > > > >
> > > > > > > ...
> > > > > > >
> > > > > > > > > > > > RCU-related configs:
> > > > > > > > > > > >
> > > > > > > > > > > >     $ grep RCU .config
> > > > > > > > > > > >     # RCU Subsystem
> > > > > > > > > > > >     CONFIG_TINY_RCU=3Dy
> > > > > >
> > > > > > I must have been asleep last time I looked at this.  I was look=
ing at
> > > > > > Tree RCU.  Please accept my apologies for my lapse.  :-/
> > > > > >
> > > > > > However, Tiny RCU's call_rcu() also avoids enabling IRQs, so I =
would
> > > > > > have said the same thing, albeit after looking at a lot less RC=
U code.
> > > > > >
> > > > > > TL;DR:
> > > > > >
> > > > > > 1.      Try making the __setup_irq() function's call to mutex_l=
ock()
> > > > > >         instead be as follows:
> > > > > >
> > > > > >         if (!mutex_trylock(&desc->request_mutex))
> > > > > >                 mutex_lock(&desc->request_mutex);
> > > > > >
> > > > > >         This might fail if __setup_irq() has other dependencies=
 on a
> > > > > >         fully operational scheduler.

This changes where the interrupts become enabled, but doesn't stop it
from happening.  It still throws a WARN after init_IRQ(). I suspect it
is not the way to proceed as there are probably many places that will
need to be changed in both common and arch specific code.  As soon as
TIF_NEED_RESCHED is set, then all the checks will need to be altered.

I think we either need to set the boot thread to !idle, avoid call_rcu()
to set TIF_NEED_RESCHED (how was this working before?  Do we need rcu
for the IRQs?), or alter the boot order (note this is NOT arch or
platform code here).

I don't like any of these.  I'd like another option, please?

> > > > > >
> > > > > > 2.      Move that ppc32 call to __setup_irq() much later, most =
definitely
> > > > > >         after interrupts have been enabled and the scheduler is=
 fully
> > > > > >         operational.  Invoking mutex_lock() before that time is=
 not a
> > > > > >         good idea.  ;-)
> > > > >
> > > > > There is no call to __setup_irq() from arch/powerpc/?
> > > >
> > > > Glad it is not just me, given that I didn't see a direct call, eith=
er.  So
> > > > later in this email, I asked Liam to put a WARN_ON_ONCE(irqs_disabl=
ed())
> > > > just before that mutex_lock() in __setup_irq().

Oh, and also:
arch/powerpc/platforms/powermac/setup.c:        .init_IRQ               =3D=
 pmac_pic_init,

>=20
> I had already found that this is the mutex lock that is enabling them.
> I surrounded the mutex lock to ensure it was not enabled before, but was
> after.  Here is the findings:
>=20
> kernel/irq/manage.c:1587 __setup_irq:
> [    0.000000] [c0e65ec0] [c00e9b00] __setup_irq+0x6c4/0x840 (unreliable)
> [    0.000000] [c0e65ef0] [c00e9d74] request_threaded_irq+0xf8/0x1f4
> [    0.000000] [c0e65f20] [c0c27168] pmac_pic_init+0x204/0x5f8
> [    0.000000] [c0e65f80] [c0c1f544] init_IRQ+0xac/0x12c
> [    0.000000] [c0e65fa0] [c0c1cad0] start_kernel+0x544/0x6d4
>=20
> Note your line number will be slightly different due to my debug.  This
> is the WARN _after_ the mutex lock.
>=20
> > > >
> > > > Either way, invoking mutex_lock() early in boot before interrupts h=
ave
> > > > been enabled is a bad idea.  ;-)
> > >=20
> > > I'll add that WARN_ON_ONCE() too, and will report back later today...
> >=20
> > Thank you, looking forward to hearing the outcome!
> >=20
> > > > > Note that there are (possibly different) issues seen on ppc32 and=
 on arm32
> > > > > (Renesas RZ/A in particular, but not on other Renesas ARM systems=
).
> > > > >
> > > > > I saw an issue on arm32 with cfeb6ae8bcb96ccf, but not with cfeb6=
ae8bcb96ccf^.
> > > > > Other people saw an issue on ppc32 with both cfeb6ae8bcb96ccf and
> > > > > cfeb6ae8bcb96ccf^.
> > > >
> > > > I look forward to hearing what is the issue in both cases.
> > >=20
> > > For RZ/A, my problem report is
> > > https://lore.kernel.org/all/3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux=
-m68k.org/
> >=20
> > Thank you, Geert!
> >=20
> > Huh.  Is that patch you reverted causing Maple Tree or related code
> > to attempt to acquire mutexes in early boot before interrupts have
> > been enabled?
> >=20
> > If that added WARN_ON_ONCE() doesn't trigger early, another approach
> > would be to put it at the beginning of mutex_lock().  Or for that matte=
r
> > at the beginning of might_sleep().
>=20
> Yeah, I put many WARN() calls through the code as well as tracking down
> where TIF_NEED_RESCHED was set; the tiny.c call_rcu().
>=20
>=20
> So my findings summarized:
>=20
> 1. My change to the maple tree makes call_rcu() more likely on early boot=
.
> 2. The initial thread setup is always set to idle state
> 3. call_rcu() tiny sets TIF_NEED_RESCHED since is_idle_task(current)
> 4. init_IRQ() takes a mutex lock which will enable the interrupts since
> TIF_NEED_RESCHED is set.
>=20
> I don't know which of these things is "wrong".
>=20
> I also looked into the mtmsr register but decided to consult you lot
> about my findings in hopes that someone with more knowledge of the
> platform or early boot would alleviate the pain so that I could context
> switch or sleep :)  I mean, an mtmsr bug seems like a leap even for the
> issues I create..
>=20
> Regards,
> Liam
>=20
>=20
> --=20
> maple-tree mailing list
> maple-tree@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/maple-tree
