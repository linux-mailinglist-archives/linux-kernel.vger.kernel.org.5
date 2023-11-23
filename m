Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E751B7F57A6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 06:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344671AbjKWFHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 00:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjKWFHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 00:07:38 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45452A3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 21:07:45 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5c194b111d6so364994a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 21:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700716065; x=1701320865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yY1sQyyb1uhz9MfrFnoGi87QF1jG7op21D45vYKRwfA=;
        b=Ff8+cwGQIUIL/LvxcBseBM7K6CUOgmtSSqqHGOM+nJroRYCqbOOPzC0hGQJmy33WEq
         aQ4nOyrLL6+2K1pxp3DnAGufHyXOzE+ifkMjFRd9uUKgTdmwxO9B9pZioK2r5oRXHY7G
         ll0iHD8cSkTW87J2VWMyjFCBxVij4/7gxnOgqN+ttrOo5D15zvHDvjM0OGLGuDBCEqlw
         puO9KBn/e3/kbw0gx16CX9OOa+JCEBY+MpO0RBQDZ8q+JY9jgHkflf27iiIS0NzczlUn
         8cI9mkDGGwtGLWoH5AiaQN4lJHJsnR6po7o8wNOvg+wr7pr3Ha5b09yE9gRlfr6NLn4F
         2HLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700716065; x=1701320865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yY1sQyyb1uhz9MfrFnoGi87QF1jG7op21D45vYKRwfA=;
        b=Gxzb3wefmHwLudKNqUqr7y3Ed7nwi+W+o/wczhzHOn2rrow9urO37OGTVxLbdboUlp
         IBJtpiDcQ+P94pQcOWceA8XiQ2v6lpcC3JHCmrafQPw/g4uOJVptTsZVOBSHOn2RuorY
         tNPFKOPi61oWk8Kp67FjuxB3/IapjjHD9U902UzUtSyZmVx3AnSXg5zBrv5rcm8Zv7o7
         4o/z+g+23umqoNYby+7eCzD7rNYWF9HBhmsmQb/mpjQm/tAi7p+PorVmeRd0Jtp0t9m4
         4q3Vrv8Jmc07pKelC+/rnEt6VyF2/4bxWBhMRhHvOAduHBlD3raXbNIOavkVw4ayTruO
         tUVw==
X-Gm-Message-State: AOJu0YxtjJFA2uHEQCw+6i+HvJVDpOZ9PH58E8TJs3NEADSho49BSHpJ
        hlT7sf3fUHamfNiCAjT6Syc=
X-Google-Smtp-Source: AGHT+IFz/3lXGWiwZTSBkr7qB201/vdd5nMWHrqRynwT5rXxDA/xIdUgmfyt7Xq43WHYUvn3g18qgA==
X-Received: by 2002:a05:6a21:3008:b0:187:a119:908f with SMTP id yd8-20020a056a21300800b00187a119908fmr4115371pzb.3.1700716064558;
        Wed, 22 Nov 2023 21:07:44 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090a2acf00b002839679c23dsm432002pjg.13.2023.11.22.21.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 21:07:44 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id CE5B010207143; Thu, 23 Nov 2023 12:07:40 +0700 (WIB)
Date:   Thu, 23 Nov 2023 12:07:40 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Chun Ng <chunn@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linux Regressions <regressions@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Ankita Garg <ankitag@nvidia.com>
Subject: Re: [REGRESSION]: mmap performance regression starting with k-6.1
Message-ID: <ZV7eHE2Fxb75oRpG@archie.me>
References: <PH7PR12MB7937B0DF19E7E8539703D0E3D6BAA@PH7PR12MB7937.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KIdW2yF7ZM5mmI7P"
Content-Disposition: inline
In-Reply-To: <PH7PR12MB7937B0DF19E7E8539703D0E3D6BAA@PH7PR12MB7937.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KIdW2yF7ZM5mmI7P
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 08:03:19PM +0000, Chun Ng wrote:
> Hi,
>=20
> Recently I observed there is performance regression on system call mmap(.=
=2E). I tried both vanilla kernels and Raspberry Pi kernels on a Raspberry =
Pi 4 box and the results are pretty consistent among them.
>=20
> Bisection showed that the regression starts from k-6.1, and the latest va=
nilla k-6.7 is still showing the same regression.
>=20
> The test program calls mmap/munmap for a 4K page with MAP_ANON and MAP_PR=
IVATE flags, and ftrace is used to measure the time spent on the do_mmap(..=
) call.=C2=A0 Measured time of a sample run with different vanilla kernel v=
ersions are:
> k-5.10 and k-6.0: ~157us
> k-6.1: ~194us
> k-6.7: ~214us
> Results are pretty consistent across multiple runs with a small percentag=
e variance.=C2=A0 Ftrace shows that latency of mmap_region(...) has increas=
ed since k-6.1.=C2=A0=C2=A0An application that makes frequent mmap(..) call=
s the accumulated extra latency is very noticeable.=20
>=20
> Please find the ftrace results and kernel config files in this folder:
> https://drive.google.com/drive/folders/1qy8YTBqxu8Gdbs7IigYbSd4FXldId5sd?=
usp=3Ddrive_link
>=20
> The test program can be found in here:
> https://drive.google.com/file/d/1tG6_BbQMCHwfKebvAIAg_xqbM_lpPcuM/view?us=
p=3Dsharing
>=20
> Info on the testing environment:
> cpufreq_governor: performance
> Test machine: Raspberry Pi 4, 8GB DDR
> SCHED_FIFO with priority 99 for running the test program
>=20
> Vanilla kernels are not tainted. However on k-6.0 and k-6.7, I have to pa=
tch the drivers/clk/bcm/clk-raspberrypi.c file with the version in Raspberr=
y Pi kernel tree for the CPU frequency governor to work.
>=20

The next step is to find the commit that introduces your regression with
`git bisect`. If you haven't done so, see
Documentation/admin-guide/bug-bisect.rst for instructions.

Anyway, I'm adding this regression to regzbot:

#regzbot ^introduced: v6.0..v6.1

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--KIdW2yF7ZM5mmI7P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZV7eGAAKCRD2uYlJVVFO
o72FAQCK5rdafR/mKJWt3KzyR6K08xDUXWyyIuqjKnddfzjV1gD/RNJ2SAAIHKWN
re/3qbV0011KdIQjaBsiuk0g/iTkaAA=
=/6zc
-----END PGP SIGNATURE-----

--KIdW2yF7ZM5mmI7P--
