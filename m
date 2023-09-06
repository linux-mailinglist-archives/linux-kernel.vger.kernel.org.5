Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC5D793EEC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241697AbjIFOdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241690AbjIFOc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:32:59 -0400
X-Greylist: delayed 271 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Sep 2023 07:32:45 PDT
Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCF61999
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 07:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=claudiocambra.com;
        s=sig1; t=1694010765;
        bh=cdH2TirNO5ueRwo8QJsKy5oOekpcUmw8wn9FTzQ22E0=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=r7T0POPVFL4NJiYNWh4f/N5/SAFxxzgmFlJAHGKRLAcpeCR52s7IMAb2tZghmzcnI
         fqPrelfxaJON+HP8ufGrLcp/ULkJXTP3T6sn7CUm4pyfhMfzZ+QbA5mXBiruSKPlyP
         2zj06LPHVXiI8SBrq4GOiUtKMNIExdI9fDb4+oNjCJKapWvvcQc9UfpA+YDbVf48qG
         lxRfzRi7Jk3t39/KueoEUhj3ITr0MdaNIV2F66NVd6DhJrTcLO1Z0XqQ0L0IcJFanv
         GtfpghUU0Hh+axo4pdxbUURrLo1aJItHGWf1pTEOS+J2WyiIaunjMauE+HBh+FAWT1
         kt/XC2nbT7dDA==
Received: from [172.20.10.2] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id 4DD05DC022F;
        Wed,  6 Sep 2023 14:32:42 +0000 (UTC)
Message-ID: <0c629825-2a70-4b79-b4df-12e826297664@claudiocambra.com>
Date:   Wed, 6 Sep 2023 22:32:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/gpu: fix docs compile error for i915
Content-Language: en-GB
To:     skhan@linuxfoundation.org, ivan.orlov0322@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20230906142746.93411-2-developer@claudiocambra.com>
From:   Claudio Cambra <developer@claudiocambra.com>
In-Reply-To: <20230906142746.93411-2-developer@claudiocambra.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: i63t-a_iJZ5NZfizd2TrqZegsTIPgzWf
X-Proofpoint-GUID: i63t-a_iJZ5NZfizd2TrqZegsTIPgzWf
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 clxscore=1030
 malwarescore=0 suspectscore=0 mlxlogscore=534 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2309060126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies, saw this has already been fixed, please disregard

Claudio

On 6/9/23 22:27, Claudio Cambra wrote:
> Compile error was caused by improper doc comment whitespacing
>
> Extra task for "Documentation task"
> Linux kernel Bug Fixing Fall Unpaid 2023
>
> Signed-off-by: Claudio Cambra <developer@claudiocambra.com>
> ---
>   drivers/gpu/drm/i915/gt/uc/intel_huc.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_huc.c b/drivers/gpu/drm/i915/gt/uc/intel_huc.c
> index ddd146265beb..fa70defcb5b2 100644
> --- a/drivers/gpu/drm/i915/gt/uc/intel_huc.c
> +++ b/drivers/gpu/drm/i915/gt/uc/intel_huc.c
> @@ -26,6 +26,7 @@
>    * The kernel driver is only responsible for loading the HuC firmware and
>    * triggering its security authentication. This is done differently depending
>    * on the platform:
> + *
>    * - older platforms (from Gen9 to most Gen12s): the load is performed via DMA
>    *   and the authentication via GuC
>    * - DG2: load and authentication are both performed via GSC.
> @@ -33,6 +34,7 @@
>    *   not-DG2 older platforms), while the authentication is done in 2-steps,
>    *   a first auth for clear-media workloads via GuC and a second one for all
>    *   workloads via GSC.
> + *
>    * On platforms where the GuC does the authentication, to correctly do so the
>    * HuC binary must be loaded before the GuC one.
>    * Loading the HuC is optional; however, not using the HuC might negatively
