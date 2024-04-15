Return-Path: <linux-kernel+bounces-145270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 003B88A51B2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94FAA1F25B51
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F5780611;
	Mon, 15 Apr 2024 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KXgGsaHa"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96B47FBBD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187931; cv=none; b=X4cAZYYqzOZDPGKP4L/2Snlh63VPmck90UOz1JBGixpJMDxRXmgSprEcZ0RRlszS24k2cgfRVC+tVfl0b5l40e0TXZCf207CmRC/8p4Mf5JfjF3Cf9Fo8yd05LQmWnOsfXLgrLIgOrafCOK5r1bdYmgsTF59X9AgebiGKzaWJC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187931; c=relaxed/simple;
	bh=kzx1DBnLKpi08wmIRgOdyPjiQsqA0gVKstuQ6y/nCbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsP+xTU0gWZxj14T/A45SClMbiLcHVZ9h5S+GXF+PtMjIrspeI1v/GfeMJkoSZRYBPiXVhubPJTTKTk/5Fes/Tft3Qy1wEfB+kC4U19qze/IrD0CdjqIFeGit6g9ii5K/9xc6LcqIi1iRr9TzKLFquFv/ZCefk6xYA5OIX5JL/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KXgGsaHa; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41879f47aa5so3530915e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713187926; x=1713792726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ru8k+KECT8Y+LJdvEDygQBg/FVMZmjLsBdJB8usbclc=;
        b=KXgGsaHa6ht+yBD/kDS1ntfiMnkRqXyAk4EIffVEfvA5FebIjigPo3MtOSjIIqHOCV
         mkoOJgGNJ+QKQXiewdeTGtsGWmIseRHjEJvLSV8YYXxmrZ5p/Ihf98P6QcLhPmnxIz+x
         mmvnAWv2V2FOIu7do6S4esg7K3786QoxzGwsQHoZ+xUSSNmwM1gCrgNxZfhJ1eu4MSVJ
         xa/jsyC38C3ikYPWUjNMlhUGtYjzwnJN1yYYB4ZlzHD1qHuRHenUb8zXMuXvYnqp/A0m
         LSFB/KPmW0Sr+pqQ3Q1YeJ7eQfLLxgQaR4jjVmVoPV+eThqfRNVEJXc/Kf0Q/OP24OVk
         7PnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187926; x=1713792726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ru8k+KECT8Y+LJdvEDygQBg/FVMZmjLsBdJB8usbclc=;
        b=Z7KSvQt70uv/6rxOU/H7SKVjmR8y3v3xaIvjV4hMOCPW3hMs9H2jx0O0K9agjsB8ZO
         yLcwtG1NPo70b3XItznA+h/ssqf93cO3lfV3FKSl7mbzhVopreFtjExBTG9rU8IURYoT
         1tsUNSFAfUjhd8ycjyRhQovxRIIg+xS0nSPKKIWGB3KAbnpbbOwbyLAwF/POwmNXxHyS
         mH3e3eL2es0qaU4hwtMis1KjAjWG71+6rFidUQQ6WesRa5Kq/yxUgpwCLC4lpGmx8ja4
         pTahYD2Okh8QgaZo486e+eLDjz1aIPnye8iDgbkaxbmrwH14Nw2OM57CY6mvAFYEVcx/
         9pVg==
X-Forwarded-Encrypted: i=1; AJvYcCXTG512hQIgjEEWzHfI655RXgYslcB8QjdH4kGpwfanmjGiSzHjfrAWSOugq6FSj1kqTfpvSUfEyWW7QGMxy5XsQ4yRJvlUMcFptoOe
X-Gm-Message-State: AOJu0YzI6jX4VKpiL9dmIjoP/554b5GOq5Zu3DXgU4CKuaRbVRS5oTOa
	mWSYZnJSa4S6uKSJbz6ouT/CfMp7rjNo07xgqtNLkklZ30DkuBnFgnSFNiPsIao=
X-Google-Smtp-Source: AGHT+IFwLZXYlG13hPnaGZf4kfDx4jn2IX9lcb0QuIHjmhGRVa6Sb/7N/TOv9F3RcRfCXz1ovTWYfw==
X-Received: by 2002:a05:600c:3b17:b0:415:6e23:28b5 with SMTP id m23-20020a05600c3b1700b004156e2328b5mr7917096wms.32.1713187926106;
        Mon, 15 Apr 2024 06:32:06 -0700 (PDT)
Received: from localhost.localdomain ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c35c400b0041638a085d3sm19634651wmq.15.2024.04.15.06.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 06:32:05 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:32:04 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH printk v4 26/27] rcu: Mark emergency section in rcu stalls
Message-ID: <Zh0sVN-bwWwavljV@localhost.localdomain>
References: <20240402221129.2613843-1-john.ogness@linutronix.de>
 <20240402221129.2613843-27-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402221129.2613843-27-john.ogness@linutronix.de>

On Wed 2024-04-03 00:17:28, John Ogness wrote:
> Mark emergency sections wherever multiple lines of
> rcu stall information are generated. In an emergency
> section the CPU will not perform console output for the
> printk() calls. Instead, a flushing of the console
> output is triggered when exiting the emergency section.
> This allows the full message block to be stored as
> quickly as possible in the ringbuffer.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Seems to be on the right location:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

