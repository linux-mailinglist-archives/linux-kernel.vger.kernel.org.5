Return-Path: <linux-kernel+bounces-160038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2628B381C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1743B216B3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2559146D52;
	Fri, 26 Apr 2024 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2M0viFA"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD021448E7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137326; cv=none; b=chsDiQQ66nJSzwq4+Eh9aYLLPZ2LKRtv9qsvzjy9xI/s2LoOgP743tYFtz1/3yeZbYIwClzd+eBWfMDzCuVldVXYnf2tleKrcnVDbt5IMf5qQcbQ/766ye8I4WNMUTQH+u9HWM6ub4GD0+2jzQZJh0aMBvmfOAvtA/M80lVIUNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137326; c=relaxed/simple;
	bh=0EjDwZWxznSCdmZifieH6x23DZR5y0YidMHayv9FCVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xf/A6jHGhCt8kOg+SExNnlniFiLZmHjjk+fcsx8SH48uQn4NFiCeyNDXC2U1uz1LhGloWrWqpgV7zKXW0O+aWfSJTcoSWXEh4TP5zz8azG4zjXWhQnvez8+TddstisNCDxGcI0Kv0jkPOvdS2VfQElEJ/JPRbY5Q0edV9WUFoPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2M0viFA; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-238fd648224so971429fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714137323; x=1714742123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuoOtUcpUko+/VSS5TWCLYfoHqgBMfRY2mIEeEzceVM=;
        b=G2M0viFA3EB9qRWl3Fy6oo4Pyse+82aScUD+VAO4SH2McYCOwOT139VOkXzQmU9CXB
         HAAKF444lq4NyjxsHfCalO8Txb8z90EhWheie+rDxoEatwbI9lw1DIw2TrDGqNBKom6O
         FCN/SmnDJcgISsH+wET4jdCUU5lrITL5VihJnbimeFWJ7Z/ntsbKJ5+RNQlV+9fCWI5s
         2jmvBUxMKF1+UQt0kokQzmosAZPKUOEYbpym/dEB5hEgAWq7FYB7H6K14rwzwipQZWrM
         okynKfyR4WY8DDbAQbpw6k/3ESHN1xbwd6ljmP8MXLMdNfmbnzhUIMtEuWsFcGUQ9Tf1
         CRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714137323; x=1714742123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuoOtUcpUko+/VSS5TWCLYfoHqgBMfRY2mIEeEzceVM=;
        b=AIGcjvfK1EPXunE5VQTT5qKP9uYEXtZuebJpaspnEBFH0pfnM9yIL84uWdsBPKN39N
         elMZON7bcEorY6xhqC9wuCUKRqR0SF44lghS96cLKiAvmg8cqTAFDcFW3VbQvtQMNRw9
         Nb2vHreSf0bShNW11Nfh7iNygivczbQyZ8Nxxl1On+2QcoG4sLjRIdyFhuzy/tu3Vk13
         Np/RomHAubNOcFwIfirk8ujYkB1QsqHu7FckZvDZoBZcoe26tPKeupJKOozE10FnXw6u
         A72YenT+NsBskXGLKoVkNXSWT2Rh87ktGFvMEqs5l8+i8BjL6PCKnWyC34v3XP68gQMY
         7ZBg==
X-Forwarded-Encrypted: i=1; AJvYcCVQr+X0IMAkyLx9JsQqwUtzTxPXgOirS7zuxun6bYtX9isClyiLzHHQXgS+mbyiIW4lCeYQ/pl/cglYyEk2POUobVpkz3KlXMPiYWrL
X-Gm-Message-State: AOJu0Yy9mPD6qaxb+nzKA3PolYIkinOeAmZUk1zw0vZbjCA20sl2erTY
	ga+QeamuzBce1yad+uQQYXb9zawQbOxL8COc32k2UKrsEAywoCyk4oijlaAVYYD7L7xk30HdtKJ
	DsMSLN06p+WS1O5ypRLc8jhEdJ7JC8WS172pg+o4VDLQ=
X-Google-Smtp-Source: AGHT+IHv9Q70wToFUPGB8Vu/MmSM2vf5h9HCjiCvHhlbFotgiGjTKOa1hQ77HNvi/4fC9LGVnz4+KPA3qAVj9amlytM=
X-Received: by 2002:a05:6870:f10c:b0:22a:a40a:a09f with SMTP id
 k12-20020a056870f10c00b0022aa40aa09fmr2581360oac.54.1714137323717; Fri, 26
 Apr 2024 06:15:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zij_fGjRS_rK-65r@archlinux> <CAEVVKH8Oagbih8E8YNPpNhyh75fWnBLdod+eEGQm9i8ciNv7sQ@mail.gmail.com>
 <47011bf2-4000-4fd8-9dd3-4c6b6a1c4a80@clip-os.org>
In-Reply-To: <47011bf2-4000-4fd8-9dd3-4c6b6a1c4a80@clip-os.org>
From: Xiongwei Song <sxwjean@gmail.com>
Date: Fri, 26 Apr 2024 21:14:57 +0800
Message-ID: <CAEVVKH9rwS6vR5_AjHyjS0vknyZvHabooE+c+k_5XNn2Rdac6w@mail.gmail.com>
Subject: Re: [PATCH] slub: Fixes freepointer encoding for single free
To: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cl@linux.com, 
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, 
	akpm@linux-foundation.org, vbabka@suse.cz, roman.gushchin@linux.dev, 
	42.hyeyoo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 8:18=E2=80=AFPM Nicolas Bouchinet
<nicolas.bouchinet@clip-os.org> wrote:
>
> On 4/26/24 11:20, Xiongwei Song wrote:
> > On Wed, Apr 24, 2024 at 8:48=E2=80=AFPM Nicolas Bouchinet
> > <nicolas.bouchinet@clip-os.org> wrote:
> >> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> >>
> >> Commit 284f17ac13fe ("mm/slub: handle bulk and single object freeing
> >> separately") splits single and bulk object freeing in two functions
> >> slab_free() and slab_free_bulk() which leads slab_free() to call
> >> slab_free_hook() directly instead of slab_free_freelist_hook().
> >>
> >> If `init_on_free` is set, slab_free_hook() zeroes the object.
> >> Afterward, if `slub_debug=3DF` and `CONFIG_SLAB_FREELIST_HARDENED` are
> >> set, the do_slab_free() slowpath executes freelist consistency
> >> checks and try to decode a zeroed freepointer which leads to a
> >> "Freepointer corrupt" detection in check_object().
> >>
> >> Object's freepointer thus needs to be properly set using
> >> set_freepointer() after init_on_free.
> >>
> >> To reproduce, set `slub_debug=3DFU init_on_free=3D1 log_level=3D7` on =
the
> >> command line of a kernel build with `CONFIG_SLAB_FREELIST_HARDENED=3Dy=
`.
> >>
> >> dmesg sample log:
> >> [   10.708715] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> [   10.710323] BUG kmalloc-rnd-05-32 (Tainted: G    B           T ): F=
reepointer corrupt
> >> [   10.712695] -------------------------------------------------------=
----------------------
> >> [   10.712695]
> >> [   10.712695] Slab 0xffffd8bdc400d580 objects=3D32 used=3D4 fp=3D0xff=
ff9d9a80356f80 flags=3D0x200000000000a00(workingset|slab|node=3D0|zone=3D2)
> >> [   10.716698] Object 0xffff9d9a80356600 @offset=3D1536 fp=3D0x7ee4f48=
0ce0ecd7c
> > If init_on_free is set,  slab_free_hook() zeros the object first, then
> > do_slab_free() calls
> > set_freepointer() to set the fp value, so there are 8 bytes non-zero
> > at the moment?
> > Hence, the issue is not related to init_on_free?
> >
> > The fp=3D0x7ee4f480ce0ecd7c here is beyond kernel memory space, is the =
issue from
> > CONFIG_SLAB_FREELIST_HARDENED enabled?
>
> My understanding of the bug is that slab_free_hook() indeed zeroes the
> object and its metadata first, then calls do_slab_free() and directly
> calls __slab_free(), head an tail parameters being set to the object.
>
> If `slub_debug=3DF` (SLAB_CONSISTENCY_CHECKS) is set, the following call
> path can be executed :
>
> free_to_partial_list() ->
>
> free_debug_processing() ->
>
> free_consistency_checks() ->
>
> check_object() ->
>
> check_valid_pointer(get_freepointer())

I understand the call path. I meant here the freepointer is not ZERO
but an illegal
value( fp=3D0x7ee4f480ce0ecd7c), then check_valid_pointer return 1 with
it's last line
and then check_object() printed out the error message. I'm not sure if I
misunderstood you.

Thank,
Xiongwei

