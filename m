Return-Path: <linux-kernel+bounces-138356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2DA89F017
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86CE1C21F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B32F15921B;
	Wed, 10 Apr 2024 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9JGd3eU"
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3773613DB9F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745751; cv=none; b=uorJHe0kJDMI5VvL1TL595UY7aoNlyHGjzVZdNWqhLmy8NpYqEsEJrzDGjpss2UVec/LonzY3fIJa8778sWHjH+pmuzPRe1XZHkuH4oAShCC1G6iZrGFiei0HYKJPZ6l4s7sqG+THRfz3RceUHIqvkioCtGqUKj61namrld0GYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745751; c=relaxed/simple;
	bh=AbyfJgbEqm3y8eA/5R8TMVFQDOgrDw8mMvC2Hb5f9hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aUW62xiwg3g7UohPQH6XXe9/0mdh8wHpTqZxTDjfEvUVkDVVxRS0aJTBGlZc+0bf+FNh3T+OfO0YoG4aQWCItsKWtytz7oNc7cCk5BzeA6ykleqV6QGzXpZm5PAqHQemdVEAhSaxkyfBdXP433ARBapjvJanLoAT6Ml9vMscNqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9JGd3eU; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a5213f0f85dso34446266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 03:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712745748; x=1713350548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AbyfJgbEqm3y8eA/5R8TMVFQDOgrDw8mMvC2Hb5f9hg=;
        b=g9JGd3eUtS2J1wd2Ui2MOiriZ2BQ3bbLcWc3AnHxFu82wnrUz9StfUFoQOdWF8pd1/
         JQVpTNfGXGzE50dYwcsDYNDx/xghEe6UtJ1XcNCEJdJjJ3QJK+7t9Dk0hDSdivAXMbQ4
         xsVYs46clTVG/LNYlxHvO4dN06e0f9WorO0q+uXwcZEoGRS6Ovh7rei9+qhhAh94E6Xv
         5vo3/xRZlHqwiMA0EZkgIFIGwHBpjovav53fUUXIHAk291nbIhDbaMfheoO+BDVVMkGC
         tnFxJV34jNKByAtKVtMbwbg/ry7HC01k6QyLHDRaD70HYnRWdscRuEHsaVH/lkMt/tlP
         1MRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712745748; x=1713350548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbyfJgbEqm3y8eA/5R8TMVFQDOgrDw8mMvC2Hb5f9hg=;
        b=KjOzMViRO6wp+qycA4hUzzI2Lqy5Ehe/PtGIkeJhHJC8w7QjX9kibsUIyA9lSxg0aP
         mQuH5e9XfP725neVuaT6wIfyT4I59P7cuXoyTCpmu4aly0d95KNrtxQcpEfcRutLWovi
         WiBUkz6bPqvVSdTg6KUOR3FKAgrGoAeO+7SHaUZWyjWX8HSo1Aub2P9hSmu+fpww7Nn0
         OtYWbF7J9q/lr+D84F1gBBYM8GGIuNo1IV/+uuJV/gLrHuzAvyUWJRPcUQamM9AzL8n8
         Bprh4Mjw1uk5pvqaE6DdXm5jK/NoRkbOkUuOAaZ6UPKcVro/vLWjVo6D4e7csQDVEHsi
         pjnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgksABf8bNa8hSyiv25obFrv3i8RhxnETOxzUlbQb9vEGp3kP2a7COJyjQyqJlDwenORUPUs9uTPVzVsXnRRlJwEku8tbY2ew/fWJ2
X-Gm-Message-State: AOJu0YwSN8BvLmXLbDPKhHbven3YV8oaE3xbTVRHSWgyUV/NfAhGkchA
	iseqxyRzg/iq4a3ItQS8VpJySCUiktV70xnYWl40kYjbLLkxH9grZNDtf1MJzS9/1ECj/xqAX7k
	SHZbeVC//8H2Y3m8O/sFE39MUm3U=
X-Google-Smtp-Source: AGHT+IEGFJO0BaJk999ZrILsT2hCzk6kVrd4mglOI/cbkdQghXzCGcxkWrmTrLybQSXUmJLhAVXSq7OJMRq5CyIMS2k=
X-Received: by 2002:a17:906:f9d1:b0:a51:9cee:4718 with SMTP id
 lj17-20020a170906f9d100b00a519cee4718mr1256690ejb.38.1712745748304; Wed, 10
 Apr 2024 03:42:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407080358.8635-1-qq810974084@gmail.com> <559293f8-0291-4059-95ac-99c5c106320a@wanadoo.fr>
In-Reply-To: <559293f8-0291-4059-95ac-99c5c106320a@wanadoo.fr>
From: Huai-Yuan Liu <qq810974084@gmail.com>
Date: Wed, 10 Apr 2024 18:41:50 +0800
Message-ID: <CAH9++vFxvYkQocw+=rtF=5B=Cfg_uwfL+Ac-vncLrSqMTuUDFw@mail.gmail.com>
Subject: Re: [PATCH V2] ppdev: Add an error check in register_device
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: sudipm.mukherjee@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Thanks for CJ's suggestion. I have modified and sent the
[PATCH V3] email.

Best regards,

Liu.

