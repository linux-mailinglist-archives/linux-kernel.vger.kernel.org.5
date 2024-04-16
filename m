Return-Path: <linux-kernel+bounces-147063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C218A6EF4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70B2284FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8699130A60;
	Tue, 16 Apr 2024 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KcH/DCXH"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C895D1304A8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278936; cv=none; b=gAO8bIVKyOWa+B18D3U6W4M8Gg6ue4yklDFBg9LuIUfh7CybQXAFg349HCFc0QFacRsSjeUo/g7rj0pPIxsNDsp7InNo9ONqqteWBt+xC7sXapTNQLMQaBhgp9Kt6J/v+VWY4h+VVNd53dcFmBfBvXSz4bJnQ28Kb6Xx08wYW5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278936; c=relaxed/simple;
	bh=qv8o5hhH38UTAvt4yDxgWYargetk899Ucn2PZF21ckg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hb4Vv9BoztOl5PA4GMdUph8Yk0Ffhl3Hm2erx41APG6wj4UCjVrku0p97+bL+/D+Dv+3hasxGVugLfqMUCwJLRagmGe/CVwa5izT+4/Hw9H5WSCMDlWDMTQjir/x44fw/7qMaBjMku9DYkTVexG/SMLKN1FQCbhuLkCvV1m9Bsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KcH/DCXH; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc74435c428so4386654276.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713278934; x=1713883734; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dkC9HeIhznIftL0Ye+AK9W/2NXZL9l/CimUWQciD92s=;
        b=KcH/DCXH0v1SM+yruW0KCDSmky8T1P11lbQNNXceh7BrncWTGR6CiYapAy270aZyQw
         bxLHGjhNs0COXGmB5Pyu431vAOFmU3Zyc8uDmL0w7L4KmuJG95fjsHoAkOkVpGMIWpX1
         DBwGgVbntwdL//92x/R0J3YoH6z3Q/rq1MmRl5sgU2jDgTdt9X0T0WMXoMApOkH9NS7d
         SqYhXQbSwyolIjpGDpD9WJlq5gVVGsryyobmf3SVxhHCKGOb8/f/QkcoDiwNCx34jg2D
         7R8tOOtci0Xaq2dyZTultf2X2V5wCKhtaDQUlij0Ubz4WvzFshHZ0XeXfe83ngOOCVHT
         ZbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713278934; x=1713883734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkC9HeIhznIftL0Ye+AK9W/2NXZL9l/CimUWQciD92s=;
        b=CrXANxwQlYj5wqzw/vTOS7bkMmuOfbYjEHldQYfo/JhLQ9DGvvppIs/xjeyuQsgRXK
         4jfDEhJOm2dWqOZs7DbvUCkHtPuwktcRDSoeldP8aKAUsKWQtGHbqca5NbMkYqI7QJwK
         Sm0BDszuOckgH6/be0EjM4XsVpBCEf7tPIowL3clJgdU7R5DcpD+aLP9MS0ZOrlLetqu
         VoNifk1s/2NqrHAVE/U2V+KwCAOXyS/6h8IHgKnW/+wZ2IqUrwLxuva4jEVpxN9LrBkc
         /ZNa+i9YUmr9N2vKKi5PNcrnLpUaQeo76/V0gUrH8JCoQadXB2CjOe0SVmJ1C552nZ8P
         8lgw==
X-Forwarded-Encrypted: i=1; AJvYcCU6OPqKYKh5dm9oUFsgr2ap+0IlcOM6RZ/Acw+lClNqmCCbFAHil6SDiG3H3/nbvUy6Llj/LXYcQ8t2dKQkbLVtV4QhK/d+A/d74277
X-Gm-Message-State: AOJu0YyZC0e5kCd/jRNlq1Bk+66VCGKowhjzmN+Gs7B2VIh8TG4bDPsF
	FhokBByn6X7zZ8VA6inssM/KL5n3ErHFI2bgsbl0pgPc3eeunYw9Urmz+ZzixQ+vIipiPyAlVfs
	KZA0yqAeDBpKV+OrGfTUEms8NrQF0NAw9qv1Ffw==
X-Google-Smtp-Source: AGHT+IGCYC5gD6+YiSV9qWfXxjR6Cc2xLYT1BNzarPUPBA5r2G201kk38iJ8HXhUjD3GioRz607Dd5DjZJEtcn7/0SY=
X-Received: by 2002:a25:2742:0:b0:dc7:5a17:6c3 with SMTP id
 n63-20020a252742000000b00dc75a1706c3mr11773509ybn.53.1713278933771; Tue, 16
 Apr 2024 07:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416-ucsi-glink-altmode-v1-0-890db00877ac@linaro.org>
 <20240416-ucsi-glink-altmode-v1-2-890db00877ac@linaro.org> <c129b349-dfaa-4b10-9b8c-6098d04b9373@linaro.org>
In-Reply-To: <c129b349-dfaa-4b10-9b8c-6098d04b9373@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 16 Apr 2024 17:48:42 +0300
Message-ID: <CAA8EJpqH2_ENE6am=m9dtwk_+_Vbc4pZG9=Y_4-b-p0fKQ4sBg@mail.gmail.com>
Subject: Re: [PATCH 2/8] usb: typec: altmode: add low level altmode
 configuration helper
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Apr 2024 at 17:32, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 4/16/24 04:20, Dmitry Baryshkov wrote:
> > In some obscure cases (Qualcomm PMIC Glink) altmode is completely
> > handled by the firmware. Linux does not get proper partner altmode info.
> > Instead we get the notification once the altmode is negotiated and
> > entered (or left). However even in such a case the driver has to switch
> > board components (muxes, switches and retimers) according to the altmode
> > selected by the hardware.
> >
> > We can not use existing typec_altmode_enter() / typec_altmode_exit() /
> > typec_altmode_notify() functions in such a case, since there is no
> > corresponding partner's altmode instance.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
>
> Should this now be called from e.g. typec_almode_notify to limit
> duplication?

typec_altmode_notify works only if there is an altmode->partner (which
we don't have with pmic-glink).


-- 
With best wishes
Dmitry

