Return-Path: <linux-kernel+bounces-16091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B38BA82388E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511DC1F215B0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84C021A06;
	Wed,  3 Jan 2024 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BlZ4cnC5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2F821A00
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5e778e484dbso96411617b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 14:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704321917; x=1704926717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEw32uZAICaUrTJvazqtRNht7MeZaCeNqiU2wjyj0fY=;
        b=BlZ4cnC5YmdohJYAJSCyfAsNJULvbvSlgVFip6EpukLQf7+QXCE4h8MLb6gZQo3sKe
         QE1XK8/pnTNc+oimFyuShZqqBQq8sB/3EpN/VktSTDgICEHfmnSE2EoudHuKBR9J7N/G
         pk4Jh5VXF830W2Cej26cwqYbREIbBjIaUR0C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704321917; x=1704926717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEw32uZAICaUrTJvazqtRNht7MeZaCeNqiU2wjyj0fY=;
        b=j9w9YKEHibWrEw3ZOaHqMDvSh1fkA9rvhiZ1V+GKnMurPZtcf8a624kSY4VqieqAxv
         HDG+ofUXVYpjmklDg7BraA6CjhZokmpm9NYDw1L6OU5f0dhdRDsVFg7vDSPcX9vH/Yre
         OJ3Kde6Y8vryvEG0h3CUGu7k3HCew2QoGS7yLVpxc0IdNmcpKpuVKpxkTYVxFA1u7QeH
         jup5VcvbnqPfYrI5THfVyTRkP+krRcki3BQiYWArr/OM+K608eaj+TF2pvKYu4yA40Fm
         z5mEpTdCaBzN11tomuK+hRSDchXF6agkbAS3USUHstG+FqG/0qToJMruvaJ90/2nKfEZ
         omNw==
X-Gm-Message-State: AOJu0Yx+XNqx9CRStYX9NFC8kOILj2MF+W1biPtI5+Cnk5LOBW50ZyRu
	O1GFX0D6mG8CfIZJQUZ5KIDUZsc3fRz3vttv3zunbiQxdfQo
X-Google-Smtp-Source: AGHT+IGf0ISPE4ggBpxDlD+a/3NTjJoY4OX3TD43ypJqeZcRDCerJpdy7UVWqgV7e0uQNp9+A7LwDs/bNXeb3klLnpw=
X-Received: by 2002:a81:5483:0:b0:5d7:1940:dd83 with SMTP id
 i125-20020a815483000000b005d71940dd83mr14754276ywb.89.1704321916927; Wed, 03
 Jan 2024 14:45:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102210820.2604667-1-markhas@chromium.org>
 <20240102140734.v4.24.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
 <CAE-0n50zkwZ8nguUJcL1gjbuavhSU_rLxfGhanxB4YA7N34hLQ@mail.gmail.com>
 <CANg-bXByhaSngW2AAG9h6DYHpiTUvh8+yw3LPU6ZQSCb62M-wg@mail.gmail.com>
 <CAE-0n52u68wMHJGe8=jz4Y1y2=voycFEY15keebz9tPDDBgiqA@mail.gmail.com> <CANg-bXDzLJgWLuH8Xj4GLYG=AVfcbmi_EfrA7DaHj4F6i350DA@mail.gmail.com>
In-Reply-To: <CANg-bXDzLJgWLuH8Xj4GLYG=AVfcbmi_EfrA7DaHj4F6i350DA@mail.gmail.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Wed, 3 Jan 2024 15:45:06 -0700
Message-ID: <CANg-bXCU0Y+GOf9w2j5suoq+F=AnE-NPuhOYjGtpoG3W4WT6-Q@mail.gmail.com>
Subject: Re: [PATCH v4 24/24] platform/chrome: cros_ec: Use PM subsystem to
 manage wakeirq
To: Stephen Boyd <swboyd@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Raul Rangel <rrangel@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Bhanu Prakash Maiya <bhanumaiya@chromium.org>, 
	Chen-Yu Tsai <wenst@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Prashant Malani <pmalani@chromium.org>, Rob Barnes <robbarnes@google.com>, 
	chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 3:25=E2=80=AFPM Mark Hasemeyer <markhas@chromium.org=
> wrote:
>
> > The DTS patch would go through the platform maintainer tree and be
> > pulled into the soc tree and sent up to mainline from there. The
> > platform/chrome patch would go through chrome platform tree and then to
> > mainline. The bisection hole will be real.
>
> I thought it would all get merged in the next merge window. How are
> bifurcations like this normally dealt with? Does one wait for the
> first series of patches to land in mainline before submitting
> dependent patches? That could take two merge windows.

The DTS dependency problem must be an exception? How are other
dependency problems resolved? For example, this patch relies on
changes to 'platform_get_irq()' which is in drivers/base/platform.c,
which I imagine is in a different subsystem and gets merged into a
different maintainer's tree.

