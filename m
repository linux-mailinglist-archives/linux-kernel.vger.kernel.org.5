Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C197C850A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjJMLwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjJMLvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:51:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D018EA;
        Fri, 13 Oct 2023 04:51:44 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-538e8eca9c1so3447418a12.3;
        Fri, 13 Oct 2023 04:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697197903; x=1697802703; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTvz1G0SfDZN3wy/vab393obWbzedDRItZ5NO5vSRVo=;
        b=O15spvtjv6/u94LiyBM39kGCy5co83nDiL4VYIaXXfhXmMYuXFVMb6F8aYNU457bCb
         8h+jOTWPYS4U5SU1vRCv9XQ/fmG0SKSjg3aKoWkrq3RCR5fcGMxhO2+YihBLS6KX0yAe
         yAQycqtc6qWOcefhqgOfOSf+Mxx4lv6nEJSW+G2W7SvDpIxMXUbor1TwbbLbDhE7dDuT
         f61YMSi09s9YLDgmokv3caUcQr3yc1ER1HWl4O35RIy9OjdHZL8zsT65VPSH0eC0bPLF
         cRidBYK94OpaJJjVCzbmRNJcangZeO8BlNPeCN1GgSHTGeG2AVGGj/d4bEr5X/NYfVov
         Mu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697197903; x=1697802703;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTvz1G0SfDZN3wy/vab393obWbzedDRItZ5NO5vSRVo=;
        b=VPP2yb0mCwk7Qk1ROAn/YYZjxSZKAiUKf5p//VQHfcZTRjDamMLZA/tvKtIWmg1ZtT
         wMybMa0ltbNuqKt84DoVzGen7CJPk3JuOcFziZ9FvoU4T8KHvV/DB8U/6x1MGxPK8g0u
         HdcHUZBKeocnUyJoBPKSuIxeSnNJksFpIrQFbEJjZCNQiAKNDgQJw+e0yHQPuFmZdvXu
         RQNLE+qvhONSH3y2EfcmYyP54oEw54tPcbHLpmEL/0MhTvZ7id01amW45Xf1HdJjocP1
         RfrLYK8WbRXeYyWkh70n9tYMGmR7iB4gcFx9NhZEktwVDh0oas8J5beyrFcOcMr7Hihh
         Ct8g==
X-Gm-Message-State: AOJu0Yz1pczTWyDeMJ+pa8c99K9D39vtGOoyoAWeM5OSMpc+u80KvM4b
        hlZ8ZN9k0HD5RU36AMMC6wQ=
X-Google-Smtp-Source: AGHT+IEaOzIItdTWLjViF/Hlr5zZPdM8Oy2fIKu1ocC8Mup7y1NdOMVnditlPuwNUXYPYynAD3SCaQ==
X-Received: by 2002:a05:6402:2293:b0:53d:7be0:4a93 with SMTP id cw19-20020a056402229300b0053d7be04a93mr9136253edb.11.1697197902825;
        Fri, 13 Oct 2023 04:51:42 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id w22-20020aa7dcd6000000b00536e03f62bcsm11430302edu.59.2023.10.13.04.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:51:42 -0700 (PDT)
Date:   Fri, 13 Oct 2023 13:51:40 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] pwm: make it possible to apply pwm changes in
 atomic context
Message-ID: <ZSkvTKr42sUZImiM@orome.fritz.box>
References: <cover.1697193646.git.sean@mess.org>
 <9c0f1616fca5b218336b9321bfefe7abb7e1749f.1697193646.git.sean@mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5BfBngWXHg8w0i9V"
Content-Disposition: inline
In-Reply-To: <9c0f1616fca5b218336b9321bfefe7abb7e1749f.1697193646.git.sean@mess.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5BfBngWXHg8w0i9V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 13, 2023 at 11:46:14AM +0100, Sean Young wrote:
[...]
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index d2f9f690a9c1..93f166ab03c1 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -267,6 +267,7 @@ struct pwm_capture {
>   * @get_state: get the current PWM state. This function is only
>   *	       called once per PWM device when the PWM chip is
>   *	       registered.
> + * @atomic: can the driver execute pwm_apply_state in atomic context
>   * @owner: helps prevent removal of modules exporting active PWMs
>   */
>  struct pwm_ops {
> @@ -278,6 +279,7 @@ struct pwm_ops {
>  		     const struct pwm_state *state);
>  	int (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
>  			 struct pwm_state *state);
> +	bool atomic;
>  	struct module *owner;
>  };

As I mentioned earlier, this really belongs in struct pwm_chip rather
than struct pwm_ops. I know that Uwe said this is unlikely to happen,
and that may be true, but at the same time it's not like I'm asking
much. Whether you put this in struct pwm_ops or struct pwm_chip is
about the same amount of code, and putting it into pwm_chip is much
more flexible, so it's really a no-brainer.

Thierry

--5BfBngWXHg8w0i9V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUpL0wACgkQ3SOs138+
s6Ef2Q//RK7bBG/JinIW0V9MUNtKX4To9kZdtN4id2USAo1xNV8LHLMsC2qzmanj
shT4vkP67aq07kWyQIbJJRmvwsCSClxrgW4u7hOYsEDWRqsEaklCGLMJLKAfrW1L
SzeeRoxyPJA7vk+i/TpD1S2UYqNFnbsb+hExbRDm5qGrHBUNZCJaOKjRrucJ1mCz
jFxB+DyMfRN4qLrgfZwXQmwgLXfpR391BcBrQ62SPK6BQsUu2BEsgjWSW+DO7iAq
PdrmSrbXzmdNEWgfTMPc9pZ9Lhw3BI+Gbj7oP4STMabu7/LdstniAgcLVMJ3X4Nb
vxQADXzW7e7T10pg3/3KsI9wHIvUnlBp1pEdutWiV48xWrD95i8qbdk4V+rMsA1s
oc68DeZjMbqCRD31w4gud01gHuDajseIgI7S2ihQcO+m+HF7Oyq25RkNqACPyfbH
ZHO72oj9jr1jmnMwyXmLxBMiZ3gD205UXcM0nau3frTrIsAaE1f1lz8Ciy55HBh9
5+L5IcQ1DBNLk1haU6m3cj8qrm/emWiZ5kP7U4jsOFjrgK+VDT1deGGixnHWNbGF
8RZdT55RP9JKv8S2hdd6M9Q7rpnr7Jd4SOhVT/Gpxz3C7moonZQugHd7Wm6cYXBK
akDzpObK4DREBtm6zJUQMlB6JIOCPJM3SugPHt3SSjxzHl3XVuQ=
=5c8a
-----END PGP SIGNATURE-----

--5BfBngWXHg8w0i9V--
