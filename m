Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B121807B57
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjLFW24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjLFW2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:28:55 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6983D59
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 14:29:00 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d0c94397c0so2141325ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 14:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1701901740; x=1702506540; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f/l6Rr9GMTmqW+sTOII/IEKtjg7NaSJo/S0s3iJkJlg=;
        b=NxqMoF+uqCBh7k+Joq0or4Iq0JU3NGTvJK+iIkKCs4wI/bsjGNnlmh64s/kDxuLn9L
         BNMqLUhdK7vjJaJOrG2raHQy3lndzXt+f8ie9rfALtfFPj6oe3ztHyJT9K+cB4OeI+VX
         JbNO5bsib62CvliOLe5v7W1rhaVLH6E1Kn/cSKsskixkJOBL+uR4VNcYiJ8i4hGggKJU
         R7bccC8ue2HqSxTvwVeAvZIp1vv3HR/14FgBPD8+YPKuRF+0cbX118NJsfei05ovqWUT
         w/HRmTETQZWcD9AtQODXxNxwcAQ1NsS2O4UehbmT1BSHEqCNMmVoqR+oMWcU79+Xhjt/
         ehXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701901740; x=1702506540;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/l6Rr9GMTmqW+sTOII/IEKtjg7NaSJo/S0s3iJkJlg=;
        b=XOhtYzQadvbAAwbt1G1MYPpDWnlO7LOETlW72/OdmMddyUMlLg2oO7+tnGtm0yYqDN
         suxjR2/wJGVxbObYv3Rc2dlJr+511e66DKM03Yva81AKutcdRAXtNGkDpC3heGmOCcBn
         KnIcHLsic7ZnbcwU6/saE7TAVI6kox4d1B0g5TjwGja0LhkaV8BlmRPkEiN5V1lZ9UUW
         aNlKwUMVA7uZ9aDW44njm919ooocXPrmrUkRGx3c/x1z8ZZU13wGbKHFfSr9z70MYdCN
         bU6l4EfoyXcfg1yQi3oqGwQgeKksZ6HuAM3xHWmodemvAVky06xi5wpaW6uWBeOwNLO+
         MYsA==
X-Gm-Message-State: AOJu0YzEEj8KwMShnS4TwO9T6kaqUWyh88x+n/opYtRWLZ/S7OxuxRjq
        01L8O67btFZDvb33xQ0gOOQaUw==
X-Google-Smtp-Source: AGHT+IF4uW9bK6yyANxChBWzaE1Y3zrx+2hRhaqcc+9gMpyrucm57mySnQFhCzjnEOUn+tcgs4FTLQ==
X-Received: by 2002:a17:902:ce8d:b0:1d0:c41b:1d0c with SMTP id f13-20020a170902ce8d00b001d0c41b1d0cmr1215417plg.75.1701901740213;
        Wed, 06 Dec 2023 14:29:00 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id ix11-20020a170902f80b00b001cfc1b93179sm305347plb.232.2023.12.06.14.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 14:28:59 -0800 (PST)
Date:   Wed, 6 Dec 2023 14:28:57 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>
Cc:     Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        cake@lists.bufferbloat.net,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Toke =?UTF-8?B?SMO4?= =?UTF-8?B?aWxhbmQtSsO4cmdlbnNlbg==?= 
        <toke@toke.dk>, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Petr Pavlu <ppavlu@suse.cz>, Michal Kubecek <mkubecek@suse.cz>,
        Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH 0/3] net/sched: Load modules via alias
Message-ID: <20231206142857.38403344@hermes.local>
In-Reply-To: <vk6uhf4r2turfxt2aokp66x5exzo5winal55253czkl2pmkkuu@77bhdfwfk5y3>
References: <20231206192752.18989-1-mkoutny@suse.com>
        <7789659d-b3c5-4eef-af86-540f970102a4@mojatatu.com>
        <vk6uhf4r2turfxt2aokp66x5exzo5winal55253czkl2pmkkuu@77bhdfwfk5y3>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eEONBPhTWRmcfcuKyiwe6pZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eEONBPhTWRmcfcuKyiwe6pZ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Dec 2023 22:18:25 +0100
Michal Koutn=C3=BD <mkoutny@suse.com> wrote:

> On Wed, Dec 06, 2023 at 05:16:28PM -0300, Pedro Tammela <pctammela@mojata=
tu.com> wrote:
> > Can't you just keep the sch-, cls-, act- prefixes for the aliases?
> > They look odd in the current patchset TBH =20
>=20
> I'm open to different better naming.
>=20
> Although, this natural option would clash with the behavior
> (modprobe(8)):
>=20
> > there is no difference between _ and - in module names =20
>=20
> Thus blacklisting via an alias vs not-blacklisting via non-canonical
> name would contradict each other :-/
>=20
> Michal

It is not clear to me what this patchset is trying to fix.
Autoloading happens now, but it does depend on the name not alias.

--Sig_/eEONBPhTWRmcfcuKyiwe6pZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEn2/DRbBb5+dmuDyPgKd/YJXN5H4FAmVw9akACgkQgKd/YJXN
5H47pA/+M4lxqb/IvlgJPzS8zJ6TBstZrVncp/IqsyJhWEf8EQPg139zasxJQiz/
PQn2bADBEqQ6c9Um8MTP4GHukWU4SRp1JiyKZxkMdabB0De7wZSUUaaFi78Y5nOu
qCpPePt9RHGgZIqPogjOJRpGl52H4Qaypieq/pg845n3DtVi6jSLa/fJc0AWmVfj
8mbXT+Uv5jRpkVOTlri+nZ+QBoJ+CEO8kUM7jQynI6hedJGbD9QHghOczxYNbN4D
UBmRNiL1ewfoH2uTH4IRSnHa3TMXv7iYMzlfDOmW1G8TTpm/6tYJ2eYArLeoRyG0
yTFbH+RZ0WCSdHcFYJG32NWV4BoikjhoBALhzYjLnxKOqck3xvHfkrf7P8WPLmRo
h9o6AuIb8ahsgYnghkuYdOhUYmijj4Fr8UWjmX1xQKPqwvTN0/6yYqikDAgh9rQT
sCGFZfbrRF8mlIG0B9KnKL5131AjxwAmrLbcLzsC6OkbgkpBsPpgunOMoCHYR/9E
84vnorBr+imly0obQ21of1yNAJ2D4JBoBnX6dnY3bHfA/jPWTwrPJKMjX8sq1XRD
3ajxlIdpmzVqWUdqpvoW4ku3vLLRh1bG5RI/WC96hzX1FAIV66G2rI53f22+P499
5Bdre8yF1LpeEceSjgU5YgWF8vSo39k+Qa6c4gm9JZ2BXvRTACo=
=L6hG
-----END PGP SIGNATURE-----

--Sig_/eEONBPhTWRmcfcuKyiwe6pZ--
