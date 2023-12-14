Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB98812DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443775AbjLNKz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443901AbjLNKzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:55:05 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9AF172C;
        Thu, 14 Dec 2023 02:54:32 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7840F40E00A9;
        Thu, 14 Dec 2023 10:54:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8arKyVspqgjI; Thu, 14 Dec 2023 10:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1702551267; bh=PmUrwYFObXJQWVp8txpK7w/dwTwMpdw31maROJ94SIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ihUCP6pfwbpL2lW0/K2c1rPJV8QLcaaax0KMA705ZC7EgP/UpEyyBKZ7e+/9FueJ5
         uV5hj7bBLvHs1RTKQc3zyhWI9ivzI+jbUTRvJVGEoM34HY0iiSL81HIxRm/Y4+HKGl
         lKb5rQB2PynTCOr8LYt25pI8jZHHmQB2OyofIKKTAduCRep2LFtZksspqJcJNi4lA5
         xUeMO8ktYKetOj7SEPIByiznA4dHNiTrABqTRu4NThjOkddoOuvq5y+kabDmutI/sE
         9y7/tAcYsAFe7JTp5p0qAfI91AERJbglTyQIOt8XibB1TmXD5dLGHODNybtK3ppqyv
         0RSrDKuenezw7DVK+KmMq4ksPVZX/hUwL2cX/Ej8sFwPMPp+bmFyajxQQxw3slmVWG
         n7W3wUcS/p4ZvKF2qxHU9aBY9Q1eLTXPC9XFQWg57RwkH1AwdcJzSCCuc0NpuhO9Te
         r1MHjTHn8blClQ8ThW+tYmTPvasDbequEQNSgjSViALp19RZO8DC0ZH3iHOr5rHBe3
         kmmHrrk46+bGXhK9tWRRg1XCBBSqgIDdjdExzEFHdhaSuXiH6IpBJ7e/Jptv3n1U/F
         4CTY4unsKyh13ABcKBeUY9yp8JSQKafmJvLuY+6Bk7poJzJcv2JgyK+22HkFXq7pXt
         AWHzgUs89QKGP6vbXa2fz1fc=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 17E7440E0140;
        Thu, 14 Dec 2023 10:54:18 +0000 (UTC)
Date:   Thu, 14 Dec 2023 11:54:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
        john.allen@amd.com, william.roche@oracle.com,
        muralidhara.mk@amd.com
Subject: Re: [PATCH v3 1/3] RAS: Introduce AMD Address Translation Library
Message-ID: <20231214105417.GMZXre2UNGMiXbyiym@fat_crate.local>
References: <20231210194932.43992-1-yazen.ghannam@amd.com>
 <20231210194932.43992-2-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231210194932.43992-2-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023 at 01:49:30PM -0600, Yazen Ghannam wrote:
> diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
> new file mode 100644
> index 000000000000..08bc46f7cabf
> --- /dev/null
> +++ b/drivers/ras/amd/atl/internal.h
> @@ -0,0 +1,312 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * AMD Address Translation Library
> + *
> + * internal.h : Helper functions and common defines
> + *
> + * Copyright (c) 2023, Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
> + */
> +
> +#ifndef __AMD_ATL_INTERNAL_H__
> +#define __AMD_ATL_INTERNAL_H__
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +
> +#include <asm/amd_nb.h>
> +
> +#include "reg_fields.h"
> +#include "stub.h"
> +
> +/* Maximum possible number of Coherent Stations within a single Data Fabric. */
> +#define MAX_CS_CHANNELS			32

Hmm, that's coherent stations and not chip select. Can we differentiate
between the two pls?

In my mind "cs" is chip select so can we call the other thing "coh_st"
or so?

...

> +/*
> + * Make a gap in 'data' that is 'num_bits' long starting at 'bit_num.

@data, @num_bits, @bit_num

This is the kernel-doc notation. You don't need make this function
kernel-doc yet but might as well get accustomed to the syntax. :)

> + * e.g. data		= 11111111'b
> + *	bit_num		= 3
> + *	num_bits	= 2
> + *	result		= 1111100111'b
> + */
> +static inline u64 expand_bits(u8 bit_num, u8 num_bits, u64 data)
> +{
> +	u64 temp1, temp2;
> +
> +	/*
> +	 * Return the original data if the "space" needed is '0'.
> +	 * This helps avoid the need to check for '0' at each
> +	 * caller.
> +	 */

Yeah, you don't need that comment - it is kinda obvious that the
function should check for nonsensical inputs.

> +	if (!num_bits)
> +		return data;
> +
> +	if (!bit_num)
> +		return data << num_bits;

Like here: I was gonna say that num_bits cannot be more than
BITS_PER_LONG (approximating here on 64-bit) because it'll turn @data
into 0 but people get what they asked for.

Might do here at least a warn or so:

	WARN_ON_ONCE(num_bits >= BITS_PER_LONG);

The same thing for the upper limit of bit_num.

> +	temp1 = data & GENMASK_ULL(bit_num - 1, 0);
> +
> +	temp2 = data & GENMASK_ULL(63, bit_num);
> +	temp2 <<= num_bits;
> +
> +	return temp1 | temp2;
> +}
> +
> +/*
> + * Remove bits in 'data' between low_bit and high_bit inclusive.
> + * e.g. data		= XXXYYZZZ'b
> + *	low_bit		= 3
> + *	high_bit	= 4
> + *	result		= XXXZZZ'b
> + */
> +static inline u64 remove_bits(u8 low_bit, u8 high_bit, u64 data)

Ditto for this one.

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
