Return-Path: <linux-kernel+bounces-56106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F5384C607
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B298287652
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AF4200C7;
	Wed,  7 Feb 2024 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulo0UHnS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D749200AA;
	Wed,  7 Feb 2024 08:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707293460; cv=none; b=tRXtUMIwC6tuuHXtS/NEVWyMLWWVyN392TmldtwuariOeifPZ6F1A3Ke6ub6UPkAATdem6MWKe63qslRI5pAecgGM2arSOOSQr88hpULuFUuowZmx6BYTltsw2PwHYN5akjvJ4sbvdL1O9mmEbtMzYwZypRXigg/F4y0ZoEh5fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707293460; c=relaxed/simple;
	bh=41KnRsDUvKntispXXEcCThUJnsAofR+h80zaEoQP39c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0jBF3DgCnM8+IVHGT5KKcmtBb1XW/V75Ps0jltffugJX2QVOdto2K3Dw+nIC+eLfkLSgB4UXEzzAVWQV9SPcmIdy7nQ1zstAB/TkRfSBS27ib8BDlDhpZyHIgSgW1z8WfjWV/i0BKDPW/SpLBJf6dTOnQ9YI5OqL3sFqr3oDtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulo0UHnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DDFC433B2;
	Wed,  7 Feb 2024 08:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707293459;
	bh=41KnRsDUvKntispXXEcCThUJnsAofR+h80zaEoQP39c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ulo0UHnS98V/lNl/ILnorI7kMENZXqYdfb/og8Xvm5vQqnJgFgTKI0DuDnl/ApolB
	 znXTtVBrgxVvusznMs1tVqGP/sDO7JN3zNWv3c/kmpT2EVdndmSp6x2J9nhaxKWMmP
	 PyPtUFpreJLWf+jQ5SPRsXTQADm1ktz2ZREJz7KDZxqM18RlDbMs3MgROClqhGHyFr
	 6wq52we96gDCRyMzeeYZyBOzEbP49XJEXrt20ITW3WA6vz7ITIsnUPyzycFPydOj81
	 44TtPUSLr90BHQss/bDfO2RmwFUeEzlpbwRfQjhX8YS1LWdVODFWuC0vicyn1CwAd0
	 KSVmH4Hfaw9Sw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-511689cc22aso69285e87.0;
        Wed, 07 Feb 2024 00:10:59 -0800 (PST)
X-Gm-Message-State: AOJu0YzCjkeHi/kHnAI81aZVlesPKM5M84/NSe5EQkVL/+ZGPjfSRvYw
	mLpkatNibWasQ9+FIKAXHKxkkJBY1KyGqhLqQcofp5ZLiXffqnDRaxlSBMS1EnOFoPbNFgSzK8G
	faDiZ2qRebtCdoKF65R+yZCs7cg==
X-Google-Smtp-Source: AGHT+IEu/ZA/n5fUMxAz/sV6rRAq0M72sp8lMZwYmsjovVXo3ZDm3EXgBzluoLytQf4PLqA/5woxhWNy7qsvX6A+CoY=
X-Received: by 2002:a05:6512:2216:b0:511:5fec:9f24 with SMTP id
 h22-20020a056512221600b005115fec9f24mr3059428lfu.16.1707293457996; Wed, 07
 Feb 2024 00:10:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207011803.2637531-1-saravanak@google.com>
In-Reply-To: <20240207011803.2637531-1-saravanak@google.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 7 Feb 2024 08:10:45 +0000
X-Gmail-Original-Message-ID: <CAL_JsqLh6dLWjGoAFFxZXncMTY0Vw4M=Ahba1q64_M-dpZ2BXQ@mail.gmail.com>
Message-ID: <CAL_JsqLh6dLWjGoAFFxZXncMTY0Vw4M=Ahba1q64_M-dpZ2BXQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Improve remote-endpoint parsing
To: Saravana Kannan <saravanak@google.com>
Cc: Frank Rowand <frowand.list@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Xu Yang <xu.yang_2@nxp.com>, kernel-team@android.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 1:18=E2=80=AFAM Saravana Kannan <saravanak@google.co=
m> wrote:
>
> Some changes to do a more accurate parsing of remote-endpoints. Making
> fw_devlink a tiny bit more efficient and the debug logs a bit cleaner whe=
n
> trying to debug fw_devlink.
>
> Rob,
>
> Can we get this into 6.8-rcX please?

I'm failing to see how this is 6.8 material?

Rob

