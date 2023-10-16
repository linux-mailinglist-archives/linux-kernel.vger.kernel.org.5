Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A868D7CB17E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjJPRlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjJPRli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:41:38 -0400
X-Greylist: delayed 1764 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Oct 2023 10:41:36 PDT
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600F783;
        Mon, 16 Oct 2023 10:41:36 -0700 (PDT)
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39GGWWJG017023;
        Mon, 16 Oct 2023 10:11:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
        message-id:date:subject:to:cc:references:from:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        proofpoint20171006; bh=bcSViWzAFYqnG2nEaSW9ZktTiKWA4GqyOXT4Ydyfm
        ho=; b=2wcicdnJYR+ub5br7JcOKnMigSQ9E/y/EaOhNzBvrswXMnX5md/XfUr+O
        fxQtmn16R0FFLjlI/0fpwe2+/penf+OPHv2PGy2E89i+NRP44mK0uhsP4uAnmuH6
        7Vr7Y5LHgne17HXnZoJn4F58hD0tFix5MhcV6HI8ShbGMt0GfNJt7TF24QFc3dQC
        2V67hkOnE/wwJgQVETGK+V0JOI+56SW3rhRltn8rw+OyHKpZ3kyd1HwSXwqzQ9B9
        Zaqygqfjc+9c6V9Hn91+giQOr7Mo4s2h/L0rIW+OZkc+8UFQnNQp21L1BRx3VR7F
        aYTtPMLxoe3LX9mvm32y7muS9Clbw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3ts6htg9hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 10:11:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQpF0+wXADINhrIsDE1tjw0rACElr0NCz0C5lIf47rIisbASrkKSsnGiQD2NUZ2m73nP9SXCRutjQWaLoPELDclzjv5vsB0OJQ2VAin2sZ5MhL/AlTnWh8Y9euuvteF4455BJo5oQidFiqi4YzqXdCjwTgND64F417evBnqHrgLCRrqWXXB5lhnxcWdMyXRr9T7gyxe81mwEBy45KHF90WIzQt3pF69xx3Q3ueG4rPXrwfRDoAC1QSf0bvNrQ2ghWPIM0+oYXk/yxEDtL4RLMCEiU6wJp1u65XwCO0RND7C+4QD+URFFTxC9b8cVUM2NROUp8TXzOEFFvI33d65PjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcSViWzAFYqnG2nEaSW9ZktTiKWA4GqyOXT4Ydyfmho=;
 b=cVqaFVK8eU9yaEYjqVBXVbYlkzcOUxWWXmDHE0k3tQPlry0lhP1eo9EyVEpIIylyfZXL3xobrGjtnPLw+xeCyZtttR+ZiX8cm2m6YBha73pabunUFJgsrAyk7GNqtjZdRNhOTm1wl1MuE9zuwlfE51Z9HAkKPM41noRCCbcR7LY8WRXhKjwJfWpCMmBiAiM7UCRf1BAO+mcWqw9n6U48DMX6nMmuhVuDMIfpbtZWmtUokPLD3pqcdEE17sBL6daIBqDvX1D9GLVfYLcuAtwD5hRBMvlOZVDk0jbbEjZ4tBlV0XH1i5PIBYenfO9lvFXat3dWTvoxh/YZ3C7ZbpOlPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcSViWzAFYqnG2nEaSW9ZktTiKWA4GqyOXT4Ydyfmho=;
 b=FCDWnodF8mE3Dd5pk0wuKAHyQUZwwZUVIkscsmpKiBc8DG4tPbo1W4X3G8JfvQXQUaOv5Pi+XWmLaM7wVMEdIVQUWP+nx07czK5zjxKOlDyCCo7ukicD/0Hl/VJP/lRAqdYUFsV42+cJQ40yTlluEznBzZPfGC6n3+PEcTFccMub6rofkcJUTRoCwyNUSbBjvRpY2S4vtHikIc/jBcA+A23XJQj9+Hr5QmlD7S9UoL1WUjHuIZuMWPxBkq47+/b9TFlCoz6iMPDNiuSr0gUwjmgg5A49WLsS40RudbHJ7/QpLIfxt//99P04cWd1Bq34QRjQYbdrct6Wk5EeIDQlFg==
Received: from DM5PR02MB3830.namprd02.prod.outlook.com (2603:10b6:4:b0::29) by
 PH0PR02MB7526.namprd02.prod.outlook.com (2603:10b6:510:5f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.34; Mon, 16 Oct 2023 17:11:55 +0000
Received: from DM5PR02MB3830.namprd02.prod.outlook.com
 ([fe80::26ba:be45:ee4b:e1ae]) by DM5PR02MB3830.namprd02.prod.outlook.com
 ([fe80::26ba:be45:ee4b:e1ae%4]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 17:11:54 +0000
Message-ID: <33830e43-00e6-4be1-855e-339d3e74a8bc@nutanix.com>
Date:   Mon, 16 Oct 2023 18:11:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] audit: Send netlink ACK before setting connection in
 auditd_set
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     audit@vger.kernel.org, Eric Paris <eparis@redhat.com>,
        jonathan.davies@nutanix.com, linux-kernel@vger.kernel.org
References: <20230922152749.244197-1-chris.riches@nutanix.com>
 <CAHC9VhTEUybqU3Bv51oLgCWLOjsFQBwzXONwXERPuM1U+vhmFQ@mail.gmail.com>
From:   Chris Riches <chris.riches@nutanix.com>
In-Reply-To: <CAHC9VhTEUybqU3Bv51oLgCWLOjsFQBwzXONwXERPuM1U+vhmFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0026.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::27) To DM5PR02MB3830.namprd02.prod.outlook.com
 (2603:10b6:4:b0::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3830:EE_|PH0PR02MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 34434a2a-35bd-469a-1eab-08dbce6aff21
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: grtQrTQ+633Axln6tgEEreIfrMtxjBSlEkepOYr31OXkiI0SYuRF/2lc6mo+RNps5EA1KvTJyQ0uar7WUf1a8S8NTZCaOeirJ1FNH8CaM/GV8HD+kGOEIMC/buRDpN7rD9Xk/cWVDkL4fMndhSSf8OQcVF4ep9hqSmmeF0b3/J7JuXIi0rrKLZFQvE4pT//nLH2L/x0MrmRXDzOA72m6plXRWlIkD3NvIa8+knjd3MdcosgEo+paMJ7xQ23Rwd7ipN0Zez5qmv3p1hLHxASkNE0RjaMab47/y7LkD1hdpdvA+mETPEvjvNGqxY9gPNx8TvjAqCtOLzJVqVBUhL45cKmjtTfGQ95OiIs3v30fBpUNCCDQf+1bw6UTdAs1UvuF+0+iYrEwOWOGFFTftKuJjVN8waqP6b9/V3gwWcd0YPPJnjrJCi2deGIWEdk8cUyl6UrdWUMCGEGtTFQZp2kdK/+A+3qSe9Hz1XnBlwZTbfV1f45wFAEjwkIkinqAWbrGy8iyHcdisM+6tVYs6lZiVt8AOV6qmAbA8nZ3sfWgTi4K9ePYuu9xFxWHzZnLWS41CnlLGu3tXLBnNCcyPzF9O4/bguJ52V7FjCzFq8DtMTPgmM1E6IamLAqVKKdmN9HNhFsLY7N1jrl8yygQ/rrfGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR02MB3830.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(2616005)(26005)(6666004)(6506007)(6512007)(6916009)(83380400001)(8676002)(44832011)(2906002)(5660300002)(8936002)(4326008)(6486002)(478600001)(316002)(41300700001)(66946007)(66556008)(66476007)(31696002)(86362001)(38100700002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N29kWW5OaHhSVHJtcHhNSFlDdElodzlEZ2Y0d1E0c2hqWW5jNktqajhieU9X?=
 =?utf-8?B?NFBHN1B3OWlQNDZQdWxuSmtrSVc4YTdaQU9XNGxHRDYySVJZRVBObHgzNDlX?=
 =?utf-8?B?UVFZd0NtYkNIYzVISzFBaHprVC9XcisrTDQ4ejZXRkJmL1ZXamV6dURTaGtS?=
 =?utf-8?B?WnZuVnY3TGNwNEF3UTlZajNpeWRRQWNlTkdzTnpBblpoWm5sOTJQQ21WL1Nm?=
 =?utf-8?B?QnRWRi9DckhDUjBjTW1UY0lCZTRyRFY5Q3pWSFNhdE5NL1dtRWV1dE5DTDRG?=
 =?utf-8?B?N0Y4c2JBZkxqdk0wSHJjOTQ5YUk3U0FSWG9BUGQ3MDgwNnBySm5TNW1kM09M?=
 =?utf-8?B?SFUzZlNhTWlESnl4cFlVZzBYalFwYWlYK0p6aEJxNWs1ZndpdGVSV1RkMnpu?=
 =?utf-8?B?Y0dDeTR0cnhPQjE1aW52WHY1VXZ3NU11ZEZvTkNXcmZTNEdYTnNIM3l0K0Jn?=
 =?utf-8?B?OE5OcHIyUVZDWC9nYmtGMndxeG9mUVVqSVdBK2hSTjA3YnVkUE0wZW1hdk15?=
 =?utf-8?B?SktlWmdtczZ1d1pqV2hCd05POGFqeUl3aUljOTgvTDk1dHpjNnU5RkRlYmRy?=
 =?utf-8?B?eUx1YkhiajYzYlJXaHlrcjE3RzZvTmxXeFVkaEdZaExBcHJpY2pFV1FVRi9K?=
 =?utf-8?B?MGFhU2NFTXFXUFYrRU1LQkZRNnFqaWw1NGo5YWVvOTdBRFNqc2RoZlIvN3g1?=
 =?utf-8?B?bk5ocS9mREdwajJOUGRzRHgzODFOblJWM3R0Sk9qTjRqR3gxUDVadXp3Q3RV?=
 =?utf-8?B?YlBxY0xHa0FlbDVLdjZhb1JveUJvTE1SdC96cUZyMmdoUnlpbXFVekhzZENN?=
 =?utf-8?B?Z3VmRXdWUE9IZVl4WUVtSGZ5TGJsL1h0a01WaDJZajhldmJyNW5oRjBBdjNp?=
 =?utf-8?B?R1NMazFQcFFnb214YktNMFlQRE5aZjJrWmVxUjF0bTJKMlhYUzdTeVhyZFpR?=
 =?utf-8?B?aEZhSHlkbW5MYnQ0ekJhbFhvZGM3RS9sRytDSDdBTG9LYXQ4QnNoQS8yVUFy?=
 =?utf-8?B?RUFFK0UzdGk2U0lLS1llVStzeTFwUGh5cms4L2d2MHBsQkxubmhmT0lWYysw?=
 =?utf-8?B?UDkzZSt2QWxmUFZkNnhoRmk3dlgxdnhOanl2V0tVQnZFemdQd2s0Wi9Hb25v?=
 =?utf-8?B?dE1rd3I4L3JZWjRzZ2hGNW9HYTNzQ0FVbkh1SjZQUGNGek5UZnV4UDVxVWRs?=
 =?utf-8?B?WlhTK0xVanhWZTlLd3crU3IzZGdCQm9SbE1mbElUN3ZoZTRTOU9pbzZaK3lS?=
 =?utf-8?B?NDJFZWhhazVUeHNQVS90cS9PNVNsWWRzSmhFN1FleHdsSU0xR0poYUVnWHE2?=
 =?utf-8?B?T3UrUFA3WmRjdkhNWWxTcDlyc2JYL3pKbWwzMTIwbjgxVDBjd3FlbFBYSDQ5?=
 =?utf-8?B?azNMYU02TDIzdk8xd0RBdUdEZ2tPSUFWVVVzYW5LNjFmNEt1N1kyVUpTVDVn?=
 =?utf-8?B?SUxEemROZ0F4Ui9wOTBPL21RUE1tTEZxYkhia09hREhBWk92OHFjNzJJWm05?=
 =?utf-8?B?eTlSdHJlT1IrWnAyazk1SXQ3OWYvQXlLN2NzQ1hVNk1KTktPMzZDUnRjWnIv?=
 =?utf-8?B?bXd4NkR6UXloY0dKN3VMTFovTUZLNHJYcEtoR09KWm0rQVZIVzRjT1V3ZDUr?=
 =?utf-8?B?bGxab0F2emtDbElVVWtiU3RPZFRjc3UwZ2xxZ0RnSkJ6MW5QdlRlaEhvaWxS?=
 =?utf-8?B?Y2ZjSEZVWUNUZjdTWTJYazdqWTk0MGFjS0dZRnJDTkJBQUFYdVRPMUZUNTg3?=
 =?utf-8?B?QVgwbjBJN2k0UWpyeFRLZXRCUmdzT3BXK1hPTWpRYVNwU0o2RkRmNDJMcW9N?=
 =?utf-8?B?RjAvMVNIdWtIRFZla0JCUVBMeUZhOGNTU0F4dHRYMjA0TVlMRGkvVXZ0c3lX?=
 =?utf-8?B?bmJxMEQ2NVYrUWVvRTdwc3hua3FiU2luMko1MUlBc1RUUUNSU1E5V1ZyNitG?=
 =?utf-8?B?RGVpcGdIZXRhSWl5ZjZlZjB3Z0Fjb25sdGM2SG03VDNsR1BUSU1qaUJmUXhu?=
 =?utf-8?B?OG9SczVGcHZFMGpGWlFYVmFpQVI0S0pRUExIajVNb0NXa1FIKzhqNVZqZTV5?=
 =?utf-8?B?OWVBUklDMmxLS1FuQU1jT2FHN2RWUlBwUXVjYWNHWmhMclB0OUZjVTB6SU41?=
 =?utf-8?B?NUNHS2VjYVA2TXppaURmZldYRitNaHpqdmUya25kYjNycE9uSnZGalBQRzds?=
 =?utf-8?B?ZFE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34434a2a-35bd-469a-1eab-08dbce6aff21
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3830.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 17:11:54.6822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjszrBLK4WESZPuIaPI01RtTyv+jf2u0FdwEiTrBcRDVfgbN2zCtrB+ZZFogsg81PAVvmbijIQyLKokz2kd2qcGweF0IJdO0oCFeuEsQ5JA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7526
X-Proofpoint-ORIG-GUID: W-D168OVJPL8C29IcZypTsU90-eBH08a
X-Proofpoint-GUID: W-D168OVJPL8C29IcZypTsU90-eBH08a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul, thanks for the reply.


 > I think the basic approach is good, but I think we can simply things
 > slightly by using a resettable boolean as opposed to an integer flag
 > for the ACK.  I've pasted in a quick, untested patch (below) to better
 > demonstrate the idea, let me know what you think.

The simplified patch doesn't look quite right. I had some trouble
getting it to apply (seems tabs were changed into spaces, even when I
downloaded the raw email). While typing it out manually, I noticed that
the condition for sending the ACK isn't correct - if NLM_F_ACK is 0 to
begin with, then ack will be false to begin with, and so no ACK will be
sent even if there is an error. Handling this case is why I used the
three-state system to begin with. I think we could still use a boolean
with a condition of just (err || ack), with the caveat that we wouldn't
easily be able to send an early ACK on an error (not that the current
patch needs this - just thinking of reusability).


 > Regardless of any other issues, I think you brought up a good point
 > about there being socket buffer contention when the queues are
 > full(ish) and an audit daemon connects to the kernel and while I'm not
 > sure that this patch will fully resolve that issue, I do think it
 > would be good to have (I'm doubtful if it can be fully resolved
 > without some really awful hacks).

That roughly lines up with what I was seeing - could you elaborate any
further on what "awful hacks" would be needed to fully resolve this?
I'm intrigued as to where else the contention could be coming from that
wouldn't be covered by this patch.


 > The ENOBUFS errors are coming from the netlink layer and are likely a
 > sign of extreme load.  I'm not very familiar with the audit userspace
 > code, but it might be helpful to see if you can increase the socket
 > buffer size for the audit daemon.

I believe we tried increasing the buffer size in the toy repro and it
didn't make much difference - perhaps doing it in the real audit daemon
might help.


 > I'm also not surprised to hear that as you increase the number of CPUs
 > the problem goes away.  With more CPUs the system is able to schedule
 > more threads simultaneously to maintain the kernel's audit queues and
 > execute the audit daemon to drain both the netlink socket buffer and
 > audit queues.

My intuition told me the opposite - that more parallel activity would
increase the chance of the socket buffer being crammed full before the
one thread could return to the audit daemon and allow it to start
processing events. Does the size/number of audit queues perhaps scale
with the number of CPUs?


 > I suggest bringing this up with the audit userspace developer if you
 > haven't already.  While we can, and should, improve things on the
 > kernel side (e.g. the patch we are discussing), it also sounds like
 > the userspace side has room for improvement as well.

That sounds like a good idea - can you point me to who that is? I was
under the impression that this was the mailing list for both the kernel
and userspace sides.


Thanks,
Chris
