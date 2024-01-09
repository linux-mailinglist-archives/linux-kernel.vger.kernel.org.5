Return-Path: <linux-kernel+bounces-20973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4DA8287F1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC83286104
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C382839AC2;
	Tue,  9 Jan 2024 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPZFhREK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130033984A;
	Tue,  9 Jan 2024 14:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF7CC43390;
	Tue,  9 Jan 2024 14:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704810162;
	bh=ryRBX6Ywx4bF68XYywhf01hIAAubq13J+4hY1ns2/Z8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WPZFhREKkRbhhlwgxX2UaooPZ+l43cW338J8zQMtDd8C82GKWlFJTy2Gl+dCsghz0
	 C8w1zzbdZq/OoLS+JFf3cxxIRVdUVjGHS9gEXtqTwQ1IJyLXhKtFuyA6cSZ5GdR8y7
	 +ke4PR4edvw6MeMaTZYIGvt7ng46GvYklEGspXl7yaHe+aZvERNvCulBZRKFrTR6+p
	 wDN0Qdhb/TYoCB9YTM2XC3lKRELbUw5YmmTCNrCLDIub5MRpRn1fAFdxBLUshe4EuI
	 rl+79L7TQ3UVDRGz7VeJcIB2a8E6rgwbqvYZ1fVeiUy+D/e7OYHt7ixgZ7xy6YHI0Y
	 c4INLzSKkvfDg==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6dde882e5ccso235605a34.3;
        Tue, 09 Jan 2024 06:22:42 -0800 (PST)
X-Gm-Message-State: AOJu0YwIDYETRD/b/KvYUw7h2Ha5AAUYWWhpTgpSgvogx58DJWOAo9yp
	FIMG1cLsha3vQsK+KToP/fiZDhoDGstGhJTNK5s=
X-Google-Smtp-Source: AGHT+IG7uz4RcDrqw+FErYNKhx1ue3obCPnmI8Yq6i5H1MvzcGf6YLxWOYuozPD6si4kA2cBuh79PZdjKo1YQ9egr6s=
X-Received: by 2002:a05:6870:9a0d:b0:203:fbf6:8c36 with SMTP id
 fo13-20020a0568709a0d00b00203fbf68c36mr7015318oab.68.1704810161980; Tue, 09
 Jan 2024 06:22:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109120738.346061-1-masahiroy@kernel.org> <20240109120738.346061-2-masahiroy@kernel.org>
In-Reply-To: <20240109120738.346061-2-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 9 Jan 2024 23:22:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNASOxi-gzve+_d-sCW9z_eEJ5TMMnzPEvN2Nj2AwgVjF9g@mail.gmail.com>
Message-ID: <CAK7LNASOxi-gzve+_d-sCW9z_eEJ5TMMnzPEvN2Nj2AwgVjF9g@mail.gmail.com>
Subject: Re: [PATCH 1/4] kbuild: create a list of all built DTB files
To: linux-kbuild@vger.kernel.org
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Simon Glass <sjg@chromium.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 9:07=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> It is useful to have a list of all *.dtb and *.dtbo files generated
> from the current build.
>
> With this commit, 'make dtbs' creates arch/*/boot/dts/dtbs-order, which


I meant arch/*/boot/dts/dtbs-list







--
Best Regards
Masahiro Yamada

