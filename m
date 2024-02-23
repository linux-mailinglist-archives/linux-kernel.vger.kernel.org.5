Return-Path: <linux-kernel+bounces-78353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8BE861251
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0092B214C5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B857EF0A;
	Fri, 23 Feb 2024 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z+U5Ejar"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115EF7D417
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693903; cv=none; b=H2y5goyEe/9Nu1v8142RZEdF2Ph35NBzZvGyFUWbB5N5pY06DBgGzACQaMz+sx0NjEY1KpAHtERaMMcTepCp21bGfYMvG062dbuyz7d6g23joDXOg/+ZpkZcZ0pkfRIZtPuDAwKwE8V0SUbR70DjIx3gMWW8G2ab64TWfLEPlp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693903; c=relaxed/simple;
	bh=3zucdEuTqNjd2l4aFxWzG4Sn8yMHQeMarA3/+gpy61c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ie63cZr2MeEW2PPZW0Z7DtPUjA1Er+e8O1FoyaAC42t21MiaSwRi+bhp6hFBzCfgpto9kTlV+rI2H9Bqcw8XGsxLNvA11tpILDA+kLZ0M2ON5pEE8+tsqNdmvVho5nmc0S8escTMHejS32VlQn0qUORyekwJ+DUKCC+Teol7WEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z+U5Ejar; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3e550ef31cso92490066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708693899; x=1709298699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9IfamIKp532gMCfozCmitNOH75viZll5QKAcnVigqEQ=;
        b=Z+U5EjarSht91xSxg3CAD/tBMuoVblYDLO1uWJm1M5KofU0+MKa/5TQ19sS2muGDrh
         1c5u0m7snvbBa3joH4QDcvR5u01yZrlmuh5bLZ9PcTAv+z/7xYQx8NirL7Pltou+g3g3
         9bdhMNH7u2xGaFa/AMGwToYLtEXaiFxUkFMSA67bUIFj3E2V9LFy9wiv6d0e9mmaCp6f
         IuGBDQjGrMNMnE2dUlPztqkVqFIEATY323+rld60cu1NIEh8bucbrxIPJwgDtW3I1+B6
         qVOb3cSDajyVRv0+Mp1LAO8NyzDLdhWnSCA2k3L+fHUWvAPTRd2oYaSSMjXqlnfLscQB
         smrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708693899; x=1709298699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IfamIKp532gMCfozCmitNOH75viZll5QKAcnVigqEQ=;
        b=hFpzS8H6pIPWP8kAusRUS6LFk8at8SGXLHWKjVkOWJk9PkfGSwcxCNGMJMo+/n8B/U
         QaFUa2k68RzECtXvDf/wFC1V3RU0ogB4u8bIFhX8Vdp2QO8OJCOP+1ICsX3Tv04OJfC3
         MVsorn5EnkOXyPpCIxMCLIU7FpZ/tSayh5uVmA0zC/Y7Cz9+coFm19Ae4DvwyMkynT4E
         EXRRnEFTPbiTZlp2Qva1dXQrXAxiXVjoju3J2DgYhWSp54TK5Sld9Tu79+y8qA1G23Ym
         WAf0xFcIENMX0GyPZPoUZfzdw+s6Bzs1Vr6hn5UGvS/lVd1il5ymSoBlbnms+6+P2F6x
         vpPw==
X-Forwarded-Encrypted: i=1; AJvYcCVzFIEGdx6m9Aaede6VrCE8xMCU7BY63e/sSrWRy0Tn9rn1OBoWunbpgwE0EmuSBhC19FJWse2VrAaAJ0ucCkZYutGNBGCm3lv1fHPU
X-Gm-Message-State: AOJu0YwYc8KNwbV3kfL/C82MkRXQvE0iJtZSMU1bMjwDJ7fXj2gzBMhA
	/YQOWgLsXyR+fyd7CtIkb0nK+UD+0RNl6RHdrJMBsFpe/PtpPZeXheFKVZKnqcg=
X-Google-Smtp-Source: AGHT+IFkS9lZ3F8MycYfE3t6zb/J+kB/eDHJsdQ3u3UAkDabPqXiTmw+SwdGjy7eQhPzdDg+PG/W1A==
X-Received: by 2002:a17:906:6cb:b0:a3e:9def:5c8d with SMTP id v11-20020a17090606cb00b00a3e9def5c8dmr1243817ejb.28.1708693899344;
        Fri, 23 Feb 2024 05:11:39 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ps7-20020a170906bf4700b00a3f1cb81dcesm2979759ejb.116.2024.02.23.05.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:11:39 -0800 (PST)
Date: Fri, 23 Feb 2024 14:11:37 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 09/26] printk: nbcon: Add detailed doc for
 write_atomic()
Message-ID: <ZdiZif8xyfbpXrc3@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-10-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-10-john.ogness@linutronix.de>

On Sun 2024-02-18 20:03:09, John Ogness wrote:
> The write_atomic() callback has special requirements and is
> allowed to use special helper functions. Provide detailed
> documentation of the callback so that a developer has a
> chance of implementing it correctly.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

