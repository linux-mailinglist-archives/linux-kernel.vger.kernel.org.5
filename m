Return-Path: <linux-kernel+bounces-90644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF968702A9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4E21C23A8A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CDB3D994;
	Mon,  4 Mar 2024 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8RaCFde"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AB23D542;
	Mon,  4 Mar 2024 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558828; cv=none; b=GJwiY+SkV+T/imu/30H/TLUoX2vxH2SbwqVWuTP/XbRgPmGEguiGyyZYVgYxPghxdjQWaWpNerJ5RwIEIqQ7IZky8vA7UuPDj4a4sLNv11lJNeAD4r+ZUl+Ww89siVWkcCY+sQQHccBSNtFNze4O5UhWw7/FNtMyK+unFnO8tKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558828; c=relaxed/simple;
	bh=5b+Cvu8XLy0B3CcR4jvhEyTFX5ESyq9Rd4VnECSgIU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9u9y2XN3hpoC9CxFosOwxSP4Tqkm0hhyecr3tycXuXj730krfV9lYAqyDnbqqtjTSdpoQQmXwHwVyuoIuB6qIAYEBXQWv5OevGsXdv7dmBIXq7GvH8YwSRghwAq3P/CJqNbZV/d9sudyT2ECU0FAKTHqgeRZ5Y77RN2+MQC99g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8RaCFde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA314C433A6;
	Mon,  4 Mar 2024 13:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709558828;
	bh=5b+Cvu8XLy0B3CcR4jvhEyTFX5ESyq9Rd4VnECSgIU8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l8RaCFdeXFpTv+51Lyzgr1WUhKCPqi9wyUt4e6vv1h51t2REPTPWmT/3twLvgfIAG
	 PpsT38GUk1KwShSmh+jGdj7j0PPznL6fUE6reuB+c3dOYkmJeQexe06wuYqYzf/7Sp
	 gHCb6XRIXDQ5Hfx6sirnUXiDgSJmmI1vZ1miCGUhRke1XBn0eTUnDKgap2HcqQ5zeU
	 ahZ2WiZgt8fx0ba1U2L05hGIzjfLS8FNKyIt7uLZLJJdjC5oYxvazxc3Qb015ZLQ34
	 NmXFt3gXQU22s5QlLYZsZmyOQR8ruizjvb07WC+bItA10Wxfr+YQIBWFdVSPc3QAun
	 c89ooRjQkoH/g==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51320ca689aso5220853e87.2;
        Mon, 04 Mar 2024 05:27:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVIKdzDWUZtNCfu5tDqjwxwd+89Lt5DAdbi6O0g37rDPCTASY/RnuCYOGW6nz7LlQaQ1Pe623KHPD++ChGsmYyx+YJGCKUqXz3GDhng5n/XX4E9f6R9mOUDeMhAXDHwSXZ1geb7AfVvwQ==
X-Gm-Message-State: AOJu0YxSYUS9YF62MS+hEsgBbQWdf5Nh025qP0a+U6Lo49eSBSaYuUIy
	v/h/nqFMVKvxpiIyA6dkBjL81EvYwckYX5LQOn86Txs/nm1A+E37qgcGczcu25XZNlc+eJ20XYM
	UOdG6rmCQ9FTjAebvvkN/7JFzwA==
X-Google-Smtp-Source: AGHT+IF7JBMM2JWKgq5k5uJTn7RrGrJFkam98ENzkoB3Q+jVvojAUOu2ms2q2hTFeUKQ3xlB/DXxSQ/G5J+GwkZpELw=
X-Received: by 2002:a05:6512:3b90:b0:513:45b6:18b2 with SMTP id
 g16-20020a0565123b9000b0051345b618b2mr2698906lfv.44.1709558826164; Mon, 04
 Mar 2024 05:27:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240302140335.117769-1-skseofh@gmail.com>
In-Reply-To: <20240302140335.117769-1-skseofh@gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 4 Mar 2024 07:26:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKNGjKq3vcUPFiPa9JNq-8=oP=uBSD=tyKaPMH3cvAkww@mail.gmail.com>
Message-ID: <CAL_JsqKNGjKq3vcUPFiPa9JNq-8=oP=uBSD=tyKaPMH3cvAkww@mail.gmail.com>
Subject: Re: [PATCH] of: fdt: add size 0 check after page align
To: skseofh@gmail.com
Cc: frowand.list@gmail.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 2, 2024 at 8:03=E2=80=AFAM <skseofh@gmail.com> wrote:
>
> From: Daero Lee <skseofh@gmail.com>
>
> After page aligning, the size may become zero. So I added exception
> handling code for size 0.

That may be true, but when would anyone only have memory regions of
less than 2 pages. In any case memblock_add will just do nothing. What
is the actual problem you are having?

Rob

