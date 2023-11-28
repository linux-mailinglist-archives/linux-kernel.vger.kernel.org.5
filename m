Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF817FB0A8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbjK1DpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjK1DpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:45:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D279B131
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:45:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3E6C433C8;
        Tue, 28 Nov 2023 03:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701143119;
        bh=mAazPanOHbBf1EpbjCncZ4WNSuavZPxp41OW/CwwxRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HtlLnnuUM2YaMmNqX508S+C7Qp+iKil8+8sWjiu/9VMk7LiQipfCRUzaBwJYhgplP
         dZxLctoALIyGJzS7OpEHbiEIklOIiiU9dxVxgoE+t5kv5YSKsSsPg2mOl7GCh5gnXj
         Q0O+zyuy0QM9VvFLnrJlDP4FHgDOq++v/yWGy3tEGRZcz52gGfFhwOhpxaOlGEvvWw
         6e6k78IR+guspkCWWf9/iIYFOiCSFAai5hVGBbbRFAtypsZSnj2WK5e2+TDBY1FkwB
         5rzKXkYdsaUfYofS5b66O8u4yyzmq5Iy2vK7aMkamVMVXq3SG2VL9gJ53d+TgcsSuy
         8tEgq1ZtFO2cw==
Date:   Mon, 27 Nov 2023 19:45:17 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jerry Shih <jerry.shih@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com, ardb@kernel.org,
        heiko@sntech.de, phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 01/13] RISC-V: add helper function to read the vector
 VLEN
Message-ID: <20231128034517.GE1463@sol.localdomain>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-2-jerry.shih@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127070703.1697-2-jerry.shih@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 03:06:51PM +0800, Jerry Shih wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> VLEN describes the length of each vector register and some instructions
> need specific minimal VLENs to work correctly.
> 
> The vector code already includes a variable riscv_v_vsize that contains
> the value of "32 vector registers with vlenb length" that gets filled
> during boot. vlenb is the value contained in the CSR_VLENB register and
> the value represents "VLEN / 8".
> 
> So add riscv_vector_vlen() to return the actual VLEN value for in-kernel
> users when they need to check the available VLEN.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
> ---
>  arch/riscv/include/asm/vector.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
