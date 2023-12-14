Return-Path: <linux-kernel+bounces-39-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACAE813B12
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221401C21002
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65F96A330;
	Thu, 14 Dec 2023 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gn1mTZJZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF196D1AD;
	Thu, 14 Dec 2023 19:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B9AC433CA;
	Thu, 14 Dec 2023 19:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702583556;
	bh=iP0gmy9ggpiUgapR7wfyfRcXDjfc80I3Ej/uLWN2PQc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gn1mTZJZM9qG+r+jH5GURDw7fKUEqQcprHLR7IZRv+Tmz6RmnbiAAw4ynzu5GxbHG
	 cjOjLDEqUHU9zC9iIU+1r9LQ+9EiER7kHuvR7vsG3IKvDLaS+mPVB71Cz+bM1H+Pr7
	 DMslcKy0MLJn+kLAql0MJHLgK3TwHLiWXow4zlSh+xNL0qx1BTLF5OT5Dez9FfNIN0
	 Ki41AcWqPCot9w6ZCykUpY4a2L/Qh7TZ/oGjomnikLJRG1QS8jGFF73/T7le9ltjuH
	 7UQeE0gjIuz3UYqW6WoMwKpNNt8LeSvq4tuYSrw2p9HQAXIy6/sNPdvXqFVZ2Nsa75
	 RvofJt4qKVtqw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e04354de0so5035362e87.1;
        Thu, 14 Dec 2023 11:52:36 -0800 (PST)
X-Gm-Message-State: AOJu0Yw9HFCmM9Sr4L6FdwezcVOgjCnALij1rNXRXk1klheEzRhpyZ4E
	aUNaoXRMCjnlXRg6YIm5UgE9aPnH5TD/4OGRJw==
X-Google-Smtp-Source: AGHT+IFdyVnqm1YYskb8kPptj/rUdQPHLnIKnUsHAQYCY7z149VjstUXp/T1fa86DyfXrZ9qKY96ARhxEFGlbGHwwTY=
X-Received: by 2002:a05:6512:2253:b0:50e:1a33:a318 with SMTP id
 i19-20020a056512225300b0050e1a33a318mr807306lfu.85.1702583554735; Thu, 14 Dec
 2023 11:52:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213224227.2191897-1-robh@kernel.org> <d6cbc405-6113-4d6c-a9b9-8f5a32159963@linaro.org>
In-Reply-To: <d6cbc405-6113-4d6c-a9b9-8f5a32159963@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 14 Dec 2023 13:52:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ=fSXn8zCiBnEr5VpU5fywCk6a=tpD_Xrk=cq-+AhpJQ@mail.gmail.com>
Message-ID: <CAL_JsqJ=fSXn8zCiBnEr5VpU5fywCk6a=tpD_Xrk=cq-+AhpJQ@mail.gmail.com>
Subject: Re: [PATCH] media: dt-bindings: samsung,s5p-mfc: Fix iommu properties schemas
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Aakarsh Jain <aakarsh.jain@samsung.com>, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 1:42=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/12/2023 23:42, Rob Herring wrote:
> > The iommus and iommu-names property schemas have several issues. First,
> > 'iommus-names' in the if/then schemas is the wrong name. As all the nam=
es
> > are the same, they can be defined at the top level instead. Then the
> > if/then schemas just need to define how many entries. The iommus if/the=
n
> > schemas are also redundant. Best I can tell, the desire was to require =
2
> > entries for "samsung,exynos5433-mfc", "samsung,mfc-v5", "samsung,mfc-v6=
",
> > and "samsung,mfc-v8".
> >
>
> ...
>
> > -        iommus-names: false
> > +        iommu-names: false
> >
> >    - if:
> >        properties:
> > @@ -102,11 +104,9 @@ allOf:
> >              - const: aclk
> >              - const: aclk_xiu
> >          iommus:
> > -          maxItems: 2
> > -        iommus-names:
> > -          items:
> > -            - const: left
> > -            - const: right
> > +          minItems: 2
> > +        iommu-names:
> > +          minItems: 2
> >
> >    - if:
> >        properties:
> > @@ -123,11 +123,9 @@ allOf:
> >              - const: mfc
> >              - const: sclk_mfc
> >          iommus:
> > -          maxItems: 2
> > +          minItems: 2
> >          iommus-names:
>
> Also here -> iommu-names

Sigh. I got distracted with everything else that needed fixing.

Rob

