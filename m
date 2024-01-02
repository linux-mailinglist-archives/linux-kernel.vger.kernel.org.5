Return-Path: <linux-kernel+bounces-14398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7DC821C83
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D60F282D0D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527A7FBEE;
	Tue,  2 Jan 2024 13:24:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F18FBE1;
	Tue,  2 Jan 2024 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6dc08cc6b9cso358481a34.1;
        Tue, 02 Jan 2024 05:24:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704201852; x=1704806652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcU2TDpQ8VVSLToE7Vm5jFsV/f9rGTk4EUxek9wNMtc=;
        b=ZyZmKZ7xH7Bc2aYxwaAkvvRHtr8dAno5YSvp7vDFbRLTJ6QrsHl0Zi2slIcgzlYBWb
         9DnWC+7f46RC2wkQZO+huPa1LcKP7/L/Oh+OiOi4mPHnl+WdxAV42xrneHnnGSL33KC3
         G9lmI1W7FmLdExJGoBNDkqr9ZWAVRxVFswJtjbWlqbE6dTnzSJ/lCb9HB6i8M6CLYj6H
         GbWZLD4tqdHPqG6xROIy4QgBYxiTNY+kPKkYydFaonGnrq8T/lD6V4VP49y+Q16/XRAW
         u9bJaIzv01fAXbSPFiekOjRoAw5keX/N4DaTLLtBy/W5cHBNd/aCYk8Du6QuoYoDiBcO
         vQKQ==
X-Gm-Message-State: AOJu0YzxiRgM781kRCwvMBwwOum0ucJMpDiN6aN+z9WKghgc24cS3DZ9
	0bYWrkgv6vIXNdlMxZ595mLplW8oPgRSl/uUDx5TBEiO
X-Google-Smtp-Source: AGHT+IE5k6ReH/T/sAdlA8Xi760DZsqWt2Y2CAdLNyXPx0M0dHY/Pv1shnE3gxIXemWFE/NIkzCzd4L/cPfToGK5uwc=
X-Received: by 2002:a4a:b38c:0:b0:595:6024:c4f8 with SMTP id
 p12-20020a4ab38c000000b005956024c4f8mr5155232ooo.1.1704201852556; Tue, 02 Jan
 2024 05:24:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4556052.LvFx2qVVIh@kreacher>
In-Reply-To: <4556052.LvFx2qVVIh@kreacher>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Jan 2024 14:24:01 +0100
Message-ID: <CAJZ5v0hRGKjwDv0VLw550CLfUuNGaVXxmvcpbFhS=PCPqY0n4A@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] thermal: netlink: Redefine the API and drop unused code
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 9:02=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> Hi Everyone,
>
> This patch series redefines the thermal netlink API to be somewhat more
> convenient to use on the caller side and drops some unused code from
> the thermal netlink library.
>
> Please refer to the individual patch changelogs for details.

No feedback, so this series doesn't appear to be controversial, and I
would like to get it into 6.8.

Tentatively queuing it up and please let me know if it is problematic.

Thanks!

