Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA6080072C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378115AbjLAJer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378109AbjLAJeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:34:25 -0500
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED18F1FCA;
        Fri,  1 Dec 2023 01:34:17 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1r8zuK-005gqn-NS; Fri, 01 Dec 2023 17:34:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 01 Dec 2023 17:34:09 +0800
Date:   Fri, 1 Dec 2023 17:34:09 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc:     olivia@selenic.com, martin@kaiser.cx, jiajie.ho@starfivetech.com,
        jenny.zhang@starfivetech.com, mmyangfl@gmail.com, robh@kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@vger.kernel.org, CobeChen@zhaoxin.com, TonyWWang@zhaoxin.com,
        YunShen@zhaoxin.com, LeoLiu@zhaoxin.com
Subject: Re: [PATCH v2] hwrng: add Zhaoxin rng driver base on rep_xstore
 instruction
Message-ID: <ZWmokVNG1ebMVNSM@gondor.apana.org.au>
References: <20231107070900.496827-1-LeoLiu-oc@zhaoxin.com>
 <20231121032939.610048-1-LeoLiu-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121032939.610048-1-LeoLiu-oc@zhaoxin.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 11:29:39AM +0800, LeoLiu-oc wrote:
>
> +static const struct x86_cpu_id via_rng_cpu_ids[] = {
> +	X86_MATCH_VENDOR_FAM_FEATURE(CENTAUR, 6, X86_FEATURE_XSTORE, NULL),
> +	{}
> +};
> +MODULE_DEVICE_TABLE(x86cpu, via_rng_cpu_ids);

Rather than moving the whole thing, just add this near the start
of the file:

static const struct x86_cpu_id via_rng_cpu_ids[];

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
