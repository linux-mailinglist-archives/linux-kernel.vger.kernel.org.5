Return-Path: <linux-kernel+bounces-18374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C62F0825C2C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9C61C23650
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086721E489;
	Fri,  5 Jan 2024 21:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AW9h3WLv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E63225AF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-425928c24easo68911cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 13:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704490736; x=1705095536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4lmApzPbOHsJj7jTz5r1h3Cjj3WPuF+sPrAF/Jaz3k=;
        b=AW9h3WLv87ttQjX8CTp5O3FCuomDKN1a0C+6yE1b7Qk34jsc9fPuuw1R8px0GIeSqY
         5Bfztegto3eMADWuy/GTR4s/zn9daEJuPgDgKhQc+zV5JJOXqJrYhYcLCYAICTvepbpL
         nTqw4/9vMjkfKCTtv4YPUlU4JsKDHE2mkpTtK/4dR4wkLALFShDGoV+ZZk5nrZXVlm8/
         M78zifc5B8z/C8MeotN+4vggp9PrTNaWxsuRK1Ov2BAK7z0ZI9is1D5FceFsC8a2Yr//
         0renxTUrcGtcICEgVm7h/KwNNwBNjLCQns1lceXGg6ZMaC4Wt9dmmMHkxocslKAgj5Bo
         fKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704490736; x=1705095536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4lmApzPbOHsJj7jTz5r1h3Cjj3WPuF+sPrAF/Jaz3k=;
        b=m9DJf9qS9vcDXLjQNSUyGcRftWcmB+gOzcrRuHR2Csh9rve8oq9XICG+6QAo8FiYZm
         SssB2hDkVbwV41zNRH5nEH1sGGKU1qist6sQ21NiJ9p/K5MUzxAP5SDzHNAJulFiHjOu
         G64Tu4vFiQvTTlqEO2SumZCtP8GrcPS9fwh+Oh3dzrO1fJN2JX+XVAjWgmu/otvmlco5
         42dWoYZTQb8Swj24SUQQNOSa+6TOIvMHvGo+KvH3UyaSKIdCg4hUbi6C/ocVBP5ZTiq2
         OmJHZ5aLH7nesIz9kgDT9HuDlm39uv7rQgtjOEhICHPbMrZNp1o3ZCDsoGLTTmegGIkt
         0WFw==
X-Gm-Message-State: AOJu0YydgJSG3I0XCVUOsEFm/c7rrJKG1CSo0FXP0hPXxI7dZZtJrPt/
	SXFfplNlZRBGMJcezWtdbXnYybqGAr29zKFX14P+8G6um9xv
X-Google-Smtp-Source: AGHT+IHP15n8S+BkUN4vPgrcnT8bxUFQCc8GHQ80R8b9qhv4fqvnuSVRjq/gDuBYwspipVDSvQ9DUICeTatEw0IWBH0=
X-Received: by 2002:a05:622a:354:b0:428:34d5:5f9b with SMTP id
 r20-20020a05622a035400b0042834d55f9bmr53401qtw.22.1704490735823; Fri, 05 Jan
 2024 13:38:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105-newemail-v1-1-c4e0ba2c7c11@google.com> <CAKwvOdnbc0Z8poK400k8dhDNjNcpWC8LsbeOSdZ5XxLm=W6k6Q@mail.gmail.com>
In-Reply-To: <CAKwvOdnbc0Z8poK400k8dhDNjNcpWC8LsbeOSdZ5XxLm=W6k6Q@mail.gmail.com>
From: Tanzir Hasan <tanzirh@google.com>
Date: Fri, 5 Jan 2024 13:38:43 -0800
Message-ID: <CAE-cH4oTTfxfGvkGCFrpCiSUOSUyL2W=isbkE+jHcRshWKnb+g@mail.gmail.com>
Subject: Re: [PATCH] mailmap: Switch email for Tanzir Hasan
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Nick Desaulniers <nnn@google.com>, Tanzir Hasan <tanzhasanwork@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 1:35=E2=80=AFPM Nick Desaulniers <ndesaulniers@googl=
e.com> wrote:
>
> On Fri, Jan 5, 2024 at 1:31=E2=80=AFPM Tanzir Hasan <tanzirh@google.com> =
wrote:
> >
> > From: Tanzir Hasan <tanzhasanwork@gmail.com>
>
> Hang on, ^ has a different From than the email From.  Did you change
> the authorship to the new email addr?  I don't care which you use but:
> 1. they should match (author and from)
> 2. verify your new email with me (mentioned below)

I didn't use git commit --amend, I suspect that b4 might be picking
this up?

Best,
Tanzir Hasan

