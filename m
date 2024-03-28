Return-Path: <linux-kernel+bounces-122682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCB088FB59
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CE1D1F28CE5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775C554745;
	Thu, 28 Mar 2024 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v3jrSrfQ"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4457A52F6D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617958; cv=none; b=tL1xYdUMW8WFHbpARjP2QBDEHaD1N6GYlt3CxXoiSHKQLz04AXZN3rCqBNuklV4uqgEZ5q+9XubeRTnK2w/RlFGYFByoXureYer2zE1DnLDMXhKRygBsn2hQ/dshWn+XkswUgwQB8b30yBVr7Y3jNiV4F2OfkcJcdBKk7+yQLc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617958; c=relaxed/simple;
	bh=lW8QqTmIIY5WWx+5Qn+Qztgo2/CDJTQmC1e6LI+YfA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgUespo51ECXQPPwgom7oXzVi3yr+CizrOUvBoTzsvGl7T3PUpsPKGPdTTSlaAz3S2T5+cG8kpkCMUZiPswjg5Ae5A3bTVkwSISyt95QCz4hKOUI/IQoOh7eQgv4Poy8Z2ttfdpti0t3VNhCRc4OJ7e8xK1JfOQ0t7Y0LrJZ+jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v3jrSrfQ; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60a3c48e70fso7493367b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711617956; x=1712222756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lW8QqTmIIY5WWx+5Qn+Qztgo2/CDJTQmC1e6LI+YfA0=;
        b=v3jrSrfQ7otb2pl6j3f+M3wl9clduYqFmhPX2yXMypjMpSBGMPxUzKYFw5cSMvIIf2
         CRCRRwF1/HXeuHD3XmaGVAFeafjBT121aX0zXXdL2MHTELLleoDriGz5r2mgIxoOaeWD
         vlbr7Z5csk+Jv8cMjEDqrJ3o2GPrYngJ2Sy3iagDAD9OCQ7U/l8mHywLhrm1RtzemmFl
         c2REYacBxvOE2sZvtwJVMU4Nw1WjTWccNsjzXcx+ILFd0qeNfnWUs4Z7VMTv6Rw2uFln
         0/2yfHlY4ayktljtFDMvwJZpday2emASH0Dei2uke6eW+GjH5K41TxfT5KvbDKlYsf7O
         9HbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711617956; x=1712222756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lW8QqTmIIY5WWx+5Qn+Qztgo2/CDJTQmC1e6LI+YfA0=;
        b=KWkX4wszJ4DZ6xEi70FelRpB3Yh+LQYug8NvvKSUcqB6RNv4iozWoYkDDSRBncHlLW
         lJcE9p3YAk4Qg/TwqvTya5uMqsLoYVVKB/8lG5kNLvUJLT8ttNfwkre05kT/R6ZAbLml
         cdPmB+sAZqjQbwm0Bffg4W5t3i+xScyBUja4jHpg1yQjodbifBO6x0FMsSOnVDX8Iy1O
         b271nqWnHVRssRFld8JZCQaeRmYEjuLba5cYm/Ox2T8XIiEZggcdBcJLaNUIjbVr91/c
         xF0pmLyBf54hLMmMy3DLY+l7aJKc1GMQ+fzj95LzMtDdW/SK8WVH5RT8Prx+6bWoQgn0
         xiYA==
X-Forwarded-Encrypted: i=1; AJvYcCVFQOrve+BO9n/0LtP4TmJQnfoNAMoRuhtBdfQv7wU216+s8kFZxRiYX+t80YK68d7s772Y1g+e03OCH2xrjXWPaHDZwbvOr7X8wPRn
X-Gm-Message-State: AOJu0Yx3v7zNtWAWuEdfJ5jILakPQAjsJlx/JE5II9J53vQpE1aaLG6j
	0m7ppK8ySvHZKWhnsr8rLZ1BQcJxmRRSy7ldm3wOBLeMugw6OoTtffnlfsAI3/c6qibMaItkpty
	MUSoOdSChgvCDJWARZpb6fhh4LcvhR/LXkjnNsw==
X-Google-Smtp-Source: AGHT+IEh33r/cMIL950w9pM6WTLyu7qyZj+WM7cEtQOkKt3p9m3geR/QDnirj2kZX/VA91a5L6wD2wnlxO8fyT2VdWc=
X-Received: by 2002:a25:c244:0:b0:dcf:3aa6:7334 with SMTP id
 s65-20020a25c244000000b00dcf3aa67334mr2478797ybf.7.1711617956166; Thu, 28 Mar
 2024 02:25:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326220628.2392802-1-quic_amelende@quicinc.com>
In-Reply-To: <20240326220628.2392802-1-quic_amelende@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Mar 2024 10:25:45 +0100
Message-ID: <CACRpkdbq5iTz6azcdSmsUiaOi97coz_XDg28RwU1GL=SQ3uXKA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add GPIO support for various PMICs
To: Anjelique Melendez <quic_amelende@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_subbaram@quicinc.com, quic_collinsd@quicinc.com, 
	quic_jprakash@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 11:07=E2=80=AFPM Anjelique Melendez
<quic_amelende@quicinc.com> wrote:

> Add GPIO support for PMXR2230, PM6450, PMIH0108 and PMD8028

All patches applied for kernel v6.10!

Thanks!
Linus Walleij

