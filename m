Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA34D7B23F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjI1Rdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1Rd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:33:28 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA56DD;
        Thu, 28 Sep 2023 10:33:25 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SHWKLo005511;
        Thu, 28 Sep 2023 17:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=zMGjwo4JgaFeiq+zEmjwtYYKC8M3XQ2E3zEbRSN8O1A=;
 b=KNYbvVMYBYjGSnlNifo2nFf8YNsS4JPNxgEkskOiMg3EvAH0ikxJ/UDp/wwBJUePVIqQ
 Vd1KpY0uVjveavekAyO1zNJw6YiLXBrW4Vl/0bYmBMhEMR0P5HiwbhEyDaJE0Z6knz5k
 HpK9GPVUslRVlNqZUD9h6HLSGmVj66wBFeimSX2o7dSrLJizghOFMSsg+q/Bm79Vvkqj
 ZZ+UVLNoWGtThHSL/wuiySxCcEMKlM3Hmf6KV35VkM4YmRyjHw03CT0FpzItHX4DUi0H
 bB2oL9NrUmLybUcz5xeNZR4Cnqu0w1JNKdHuiNqA3EZ7pIlteJ1AQfatcaimq0ukDsm7 iQ== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3tdbgg1hag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 17:32:23 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 99832805E57;
        Thu, 28 Sep 2023 17:32:21 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 0667A813810;
        Thu, 28 Sep 2023 17:32:18 +0000 (UTC)
Date:   Thu, 28 Sep 2023 12:32:17 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org,
        Justin Ernst <justin.ernst@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/platform/uv: Annotate struct uv_rtc_timer_head with
 __counted_by
Message-ID: <ZRW4lVMBvyrxhTKq@swahl-home.5wahls.com>
References: <20230922175151.work.118-kees@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175151.work.118-kees@kernel.org>
X-Proofpoint-ORIG-GUID: I9OyhDCJxtf1u8SrtUrYsGnhjBLOHgpZ
X-Proofpoint-GUID: I9OyhDCJxtf1u8SrtUrYsGnhjBLOHgpZ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_16,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280152
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:51:51AM -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct uv_rtc_timer_head.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Steve Wahl <steve.wahl@hpe.com>
> Cc: Mike Travis <mike.travis@hpe.com>
> Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> Cc: Russ Anderson <russ.anderson@hpe.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> ---
>  arch/x86/platform/uv/uv_time.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
> index 54663f3e00cb..ff5afc8a5a41 100644
> --- a/arch/x86/platform/uv/uv_time.c
> +++ b/arch/x86/platform/uv/uv_time.c
> @@ -53,7 +53,7 @@ struct uv_rtc_timer_head {
>  	struct {
>  		int	lcpu;		/* systemwide logical cpu number */
>  		u64	expires;	/* next timer expiration for this cpu */
> -	} cpu[];
> +	} cpu[] __counted_by(ncpus);
>  };
>  
>  /*
> -- 
> 2.34.1

Looks good, thanks.

Reviewed-by: Steve Wahl <steve.wahl@hpe.com>



-- 
Steve Wahl, Hewlett Packard Enterprise
