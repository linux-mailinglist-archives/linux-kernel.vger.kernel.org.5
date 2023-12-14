Return-Path: <linux-kernel+bounces-237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABE7813E22
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2FC1C21E88
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60A76C6D0;
	Thu, 14 Dec 2023 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUQ7LYxB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B756C6C0;
	Thu, 14 Dec 2023 23:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-20308664c13so58289fac.3;
        Thu, 14 Dec 2023 15:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702595731; x=1703200531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3/uJiT9TQ0Tlop4JkaKoN9q1vVnNppY7dZy/9puybk=;
        b=BUQ7LYxBjuGQXNA5D43CytBbZD1jcBcrlcGU2diSK3jvHf0Hgj6qRU59kzGbtmZ7W1
         Bl7ykf2ykjAEw9H4N0Y5kVkX96dSUAMborNxCe4e7Kls9KRdTvmfI8okaTY42are8dMC
         XURwNW3DfWGupd8Jlf5oItF+CPKcxdupnuQiRAdUI02QwC1guESbvC2CAkCry4TkMEgA
         qMIs9bQFjY/gQYB/CWA73YmiNOEiCTHPYOsLlnHHJEGvb3h18j1Vm1KJGg0gyorO4pUN
         h7N+RyxHnHsgG7RrctNFDtANU8OL90SYfYJg8Bn7a11KTq1vL93Bahl7Wc6CXcxQ7jXt
         4M3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702595731; x=1703200531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3/uJiT9TQ0Tlop4JkaKoN9q1vVnNppY7dZy/9puybk=;
        b=Da2ZJM6fuvgpYxR8pgyDiU479m1HLfNdYb9MHU3/Hhe7EIVmBt3kpATiOrT+0jZh2l
         l3bER1E1tpD0jOR22hC2BNJpv4N5JCLXg9ngUON2/2J8dQg1L3xSu54Q+B0v7OqwmltN
         Fn6nLLsqjmn5yfImDTmfpQHsKErK6GLf88YCy+lc2DpjWlLvhrC+7CubuMHjFHtRILtF
         9vH7GD8+necZd5cFrlSlL0EpnlQkR1vXwjpahyQqdvV0QeY42orFUA1HqMmiALUYskzC
         yNFZGXPANefFJpNyaMhKQh2dy9lJCnK4LBM4H4rrCFiItmnlSCtpGUyCy7fMLtkP46Dp
         YH3g==
X-Gm-Message-State: AOJu0Yw5Xj4QxEltjn5FrRgR+jhAZAQd8twlnzGxF6beHNmS9xmNhVhX
	T5q1Jv074SXFs/76B6tqyBedJ3e0ptcMhLzgFlk=
X-Google-Smtp-Source: AGHT+IGf5A5/9xmsit3EyjeIc1AEeS+Cc2hfGJnpn+1Fzx+YwOhgmyACnbbn8yWoh3AaTsyN162EwwmVQNrFVaqzgKU=
X-Received: by 2002:a05:6870:b289:b0:203:200e:bf00 with SMTP id
 c9-20020a056870b28900b00203200ebf00mr4061756oao.87.1702595730658; Thu, 14 Dec
 2023 15:15:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214134702.166464-1-vishnuocv@gmail.com> <702d46c3-f4a1-142e-c8a3-1e462934f9ea@linux.intel.com>
In-Reply-To: <702d46c3-f4a1-142e-c8a3-1e462934f9ea@linux.intel.com>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Fri, 15 Dec 2023 08:14:53 +0900
Message-ID: <CABxCQKu9kD4HkHT0ffNc_CTsD9y0_p7QQ0b--aLFP4B_JVD+=A@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: thinkpad_acpi: fix for incorrect fan
 reporting on some ThinkPad systems
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	markgross@kernel.org, vsankar@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

Thank you for the review.

Vishnu

On Thu, Dec 14, 2023 at 11:53=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Thu, 14 Dec 2023, Vishnu Sankar wrote:
>
> > Some ThinkPad systems ECFW use non-standard addresses for fan control
> > and reporting. This patch adds support for such ECFW so that it can rep=
ort
> > the correct fan values.
> > Tested on Thinkpads L13 Yoga Gen 2 and X13 Yoga Gen 2.
> >
> > Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> > Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
> > ---
> > -Improvements to comments as requested.
> > -Removed the usage of unlikely/likely while reading fan speed.
> > -Improved and clearer print statements to match the current style.
> > -Changed seq_puts to seq_printf of an unrelated section of the patch.
> > -Improved the readability of the code.
> > -Added more clearer comments.
>
> Nice work, thanks.
>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>
>
> --
>  i.



--=20

Regards,

      Vishnu Sankar
     +817015150407 (Japan)

