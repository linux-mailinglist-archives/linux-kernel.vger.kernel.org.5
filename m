Return-Path: <linux-kernel+bounces-94336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9228E873D93
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9874B21B5A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A7C13BADE;
	Wed,  6 Mar 2024 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wz/MBBNa"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED3D135A4C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709746576; cv=none; b=Or4IvHCYwXgU/fWQT9xvbbS4EOSTYvfGABDvGJ2Oksdp6EYjIleDipC6QoWoeQs76AV+PcBJKJFVgXlWIwsT7EIszR/IsDmqPZZ2xIwK5Y7xtDGxJa/40dFrDWQNaNdablyAGW+Igx1nCN1yT4LQGoX6eqpGuDZTfqPfOpfc+Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709746576; c=relaxed/simple;
	bh=cUyDcNC/LTkBVNTzTcTw3YOnUioZAJDXkPPFotLuCH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AW5nwhG38oQxU23dzPnnQa6RRy/YpWWED8Cj2F7LPY41BDOFrolu1ucT0ItLZm1ccNeJgHNhOfNe5oAi/1FeR3henQY8gL5dXUC+uMAHA9BEZbEbQN1shiMIkCRni8iJeMJZDcUJyaHv6VBz9Gb61ILAR9EoC+9OTlTyr783RDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wz/MBBNa; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56781070f38so1965191a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 09:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709746573; x=1710351373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q88pdzkeevTU/Ovl2T1JSrp/SxlpWNguLRggqavLH88=;
        b=Wz/MBBNaNTY85MfOa80MQOV/lLx3PJ6OOnQz8M3/g/dPJlzuU50MlQe8Tr/w1x7xSp
         PprNrNk8p8j3ILI3qNIEhrWa80AripKRMJqiYlWG5+4znY9SS+jAv6qhJCT7boS9LZjk
         dk/yBaOdXkTkmwv3R29XBuOH9Vyu7HDtwGLtKqFBMLnh+VH6NCPBG2Rhp0K5xQZP3Qvm
         1NjU0NvB1bVQdWtvji/DMUO1+0wcXVfUg/8dzkfTOVMJLcVtCASGKDYck8WBcSPFiQhP
         xHPt5lQyr5qyNwf0UsCEm9wAK5wbiawkOqmvnJg0rf6MlAlyuGtgR3bNT4EqVzQrAtAp
         fKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709746573; x=1710351373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q88pdzkeevTU/Ovl2T1JSrp/SxlpWNguLRggqavLH88=;
        b=TTavBEs9gvSGtUXDPbGfr4hE6sZdpCPK7RKAkxn5NUeHNTvNi4YD+s0qgqqIXi5WmY
         kOROSSJMDudy+oFUeAKIsAEy5EfbVHgWjvM3sj5Is7sjJpByv/zWNYXvNxqa8sL3aJLg
         643mfS9VxiZk18BjFZGFWyoOa/uk+NgW1B2o+7TWiINU+SSey1TZR3xn/+5IAX2KUC5J
         Gj6xJmrEJ1h+OQFyaOpI5iQqHSv9oE7iGF3UkOM4rEzbWhapRsRK78X8TFoIn9HFMsOY
         VF1xDPcDZMnZVbjtsewS/yRm/g5tY0uxlltK/pJ+9zUVclPL1lpHRm8ajvS8ZKYviZ4G
         SjVQ==
X-Gm-Message-State: AOJu0YwmjRzgxnvmGEXNuED0cuk/eEynXrzD447Ys2ovvxwuVQxVzfJv
	ZYq7+YclVAkg7AcTXRZSrlp2/2g8VMSStiE21rXOP43h41fDnPPG
X-Google-Smtp-Source: AGHT+IG5XlKHvUi+RmQJQVL7A7olBfvW+6kABQO3o/thrMI8PXTTffkoH5uLonpIwQ4w0Hrvhu2+2w==
X-Received: by 2002:a17:906:d287:b0:a3f:50f0:7a0a with SMTP id ay7-20020a170906d28700b00a3f50f07a0amr5938498ejb.20.1709746573281;
        Wed, 06 Mar 2024 09:36:13 -0800 (PST)
Received: from andrea ([31.189.122.3])
        by smtp.gmail.com with ESMTPSA id um15-20020a170906cf8f00b00a443e6f9403sm7368635ejb.54.2024.03.06.09.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 09:36:12 -0800 (PST)
Date: Wed, 6 Mar 2024 18:36:09 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Kenneth-Lee-2012@foxmail.com
Cc: linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
	paulmck@kernel.org
Subject: Re: Question about PB rule of LKMM
Message-ID: <ZeipiSVLR01jmM6b@andrea>
References: <tencent_C5266B7D6F024A916BCA7833FDEA94A74309@qq.com>
 <Zedd18wiAkK68Lzr@andrea>
 <tencent_744E0AF832049C200F96FD6582D5114D7F0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_744E0AF832049C200F96FD6582D5114D7F0A@qq.com>

> > In this sense, the propagation rule (like other "acyclicity"-constraints of
> > the LKMM) expresses "temporal ordering", and any pb-link is (by definition)
> > an "execute-before"-link.  The file explanation.txt can provide additional
> > context/information, based on the (informal) operational model described in
> > that file, about this matter.
> 
> So it is just a rule in the sence of mathematics? I think it would be better
> if there were some explaination in the explaination file. It is
> descripted in nature language, the reader might not notify it is just a
> mathematics rule. And you cannot say an action executes before another
> because they are in the pb link. It becomes a cycling in logic...

I think you're on to something, explaining mathematical axioms or rules has
never been an easy task AFAIU.  ;-)  (and that's why feedback is welcome)

The remark could be to continue to consider such rules "generalizations" of
properties met by several hardware models or other specific contexts, rather
than (mere) logically-derived facts.

  Andrea

