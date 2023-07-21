Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE7F75C75F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjGUNKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGUNKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:10:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCDC10CB;
        Fri, 21 Jul 2023 06:10:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E173E61A73;
        Fri, 21 Jul 2023 13:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E21C433C8;
        Fri, 21 Jul 2023 13:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689945030;
        bh=fFYghksYJ5mrpl6JUo/uJE8f87XTyNtDPP/p/SwJ02U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=inoY0JWEyp4n+YaE0gGTHnVKBGbQK4g0VVV91kRHx3IMFFjia0wKKmFSikFJQlysv
         LuwUppIfD0bsY0I3hAJC4VnPK3Zk3OJmD8X/ptbzvJwi/39W01nVzdxXDnW0hCJ8sv
         IpFLmO5hHU0O8pGNxg/1KpiTxSWUMPM6BDMdCH/KxDcFoEZoCfaW0r3rKIQtIJh9tI
         JI0HtghkUK/WsRG1DjS0uLkGUmJGysKod7qdAkVCbtZG6QRO6p54CbaM2Auc5tHHd3
         qSo8WLTnZghwYMlXnPKp62VUrJEm7E0vKVezK6MFlkziR3Ea91mT3x4TOTwp8w/wrC
         GscAWc04D6Hng==
Date:   Fri, 21 Jul 2023 09:10:26 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     Anh Tuan Phan <tuananhlfc@gmail.com>
Cc:     william.gray@linaro.org, rongtao@cestc.cn, ricardo@pardini.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] tools/counter: Makefile: Replace rmdir by rm to avoid
 make,clean failure
Message-ID: <ZLqDwg44UFNrrQfZ@ishi>
References: <d4080db5-1825-2848-079a-8bb674d8ee44@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ABYG4snp4xgxCo8T"
Content-Disposition: inline
In-Reply-To: <d4080db5-1825-2848-079a-8bb674d8ee44@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ABYG4snp4xgxCo8T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 16, 2023 at 10:44:56PM +0700, Anh Tuan Phan wrote:
> Use rm -df instead of rmdir -p since rmdir requires the directory exist
> so it causes "make -C tools clean" failed if someone only builds other
> tools but not counter.
>=20
> Fixes: 228354ed692f ("tools/counter: Makefile: Remove lingering
> 'include' directories on make clean")

Hi Anh,

Tags should span a single line even if they are long. This is minor
enough that I will clean it as I pick up the patch so no need to worry
about it this time. In the future, run script/checkpatch.pl on your
patches to catch these type of mistakes that are easy to miss.

I'll queue this patch for the counter-fixes branch.

Thanks,

William Breathitt Gray

> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> ---
> Changes from v1:
> - Use rm -df instead of checking the directory exists
> - Add Fixes tag
> - Update the patch title
> Reference:
> - v1:
> https://lore.kernel.org/all/362e127d-6018-5fc6-247b-3c729b99d946@gmail.co=
m/
> ---
>  tools/counter/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/counter/Makefile b/tools/counter/Makefile
> index a0f4cab71fe5..b2c2946f44c9 100644
> --- a/tools/counter/Makefile
> +++ b/tools/counter/Makefile
> @@ -40,7 +40,8 @@ $(OUTPUT)counter_example: $(COUNTER_EXAMPLE)
>  clean:
>  	rm -f $(ALL_PROGRAMS)
>  	rm -rf $(OUTPUT)include/linux/counter.h
> -	rmdir -p $(OUTPUT)include/linux
> +	rm -df $(OUTPUT)include/linux
> +	rm -df $(OUTPUT)include
>  	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
>=20
>  install: $(ALL_PROGRAMS)
> --=20
> 2.34.1

--ABYG4snp4xgxCo8T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZLqDwgAKCRC1SFbKvhIj
K/EgAP9E3YVYGgBmTKzYt7HtWSEl6P4V3/3L5q07eEOwJ5briAEAwpmxGhABSqXF
ziGiYjvVWkX/M+D2Pd7OLGXFcM9p5QQ=
=LKOM
-----END PGP SIGNATURE-----

--ABYG4snp4xgxCo8T--
