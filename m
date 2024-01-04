Return-Path: <linux-kernel+bounces-17290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2766824AF1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C731F232C7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD432C855;
	Thu,  4 Jan 2024 22:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fliKLtkR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60C02CCAD;
	Thu,  4 Jan 2024 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5e76f7ca09cso1023667b3.0;
        Thu, 04 Jan 2024 14:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704407865; x=1705012665; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jfP13WYF364mOWLMsaSyApRyyJyIZ4hmplq28T3PTRw=;
        b=fliKLtkRxSGdgiXdmoh/E8+F9SbsayvWfKEhq+DVOWu7DuJ4rUsEISofdBLLOd5jOS
         L7miFeWcIMM35oSXHWyyMR+VRADha3IbFMVHUouPIHadUTpj8T9p2boxPeLrAmMF4Kze
         QDJjAkX4h11Ywvowc1lxuMZsVQ2UfcECJ1XcUl2z9Fx7D/uthZcC95CixH7wYOnXie+k
         jKVo+tpu83aIgsKqLie9oh20rPmJUxGhn8RK0O8s7MckqY+gdF/Geb7m15Vzdl/NRA3e
         rAVsYYKAdWiLFSghvK3an/kbj5AXABq8ud+5J6ZZzGJz4HsXFzxNRLeuh5KuRl/EjEHj
         /S3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704407865; x=1705012665;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jfP13WYF364mOWLMsaSyApRyyJyIZ4hmplq28T3PTRw=;
        b=j5xytDYVN4HTev16A082SSnPM/WNNcjXzqlw3fIto3xGpngNMDxvYhirkIUzV+Fy1m
         2Eic3xBTHMkZutHiF33GxyzHDP79JlTIBp3z4U6BgfmkA6xglYQ5nqgwfJCZMP+lymEY
         60P1nIvUwdACh+ZbJq17sIXTvPBFS8TEo0RpDkvySDxT9b+DAA+rQQk7hSzShq+Ma1oj
         2NvMmI4IDbhUCWayHx6XfaEBkPRdc6OR59T60GauzSOFY8QXgDhx5EL8LnxMcCjdIO+9
         p7cPF5+kALQBRPtlTVfBgItPlKMAWRofbO00YxVJgWf91DNvlR4ubfrgXPYg6FMj9qgR
         1dgQ==
X-Gm-Message-State: AOJu0Ywy7DKkLBQyzrIKF0CgfeRiy56X9o7zDw1XRjLHpFpUyaoq7Fip
	BpeiQpwjw4hCJNwBeJskvjw=
X-Google-Smtp-Source: AGHT+IHq2RMkPMRo0ssm7elkHl7qRL3PSosWZ1lovYwdIkmFGQQYHTR7vHuoUPdorYGIje436U2mXQ==
X-Received: by 2002:a0d:f3c4:0:b0:5ef:e5ff:ab82 with SMTP id c187-20020a0df3c4000000b005efe5ffab82mr2261109ywf.4.1704407865480;
        Thu, 04 Jan 2024 14:37:45 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id h65-20020a815344000000b005f46cd4858asm148247ywb.72.2024.01.04.14.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 14:37:44 -0800 (PST)
Date: Thu, 4 Jan 2024 14:37:42 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Mahesh Bandewar <maheshb@google.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>,
	Don Hatchett <hatch@google.com>, Yuliang Li <yuliangli@google.com>,
	Mahesh Bandewar <mahesh@bandewar.net>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCHv3 net-next 2/3] ptp: add ioctl interface for
 ptp_gettimex64any()
Message-ID: <ZZczNlXzM8lrZgH5@hoboy.vegasvil.org>
References: <20240104212439.3276458-1-maheshb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240104212439.3276458-1-maheshb@google.com>

On Thu, Jan 04, 2024 at 01:24:39PM -0800, Mahesh Bandewar wrote:

> @@ -226,6 +238,8 @@ struct ptp_pin_desc {
>  	_IOWR(PTP_CLK_MAGIC, 18, struct ptp_sys_offset_extended)
>  #define PTP_MASK_CLEAR_ALL  _IO(PTP_CLK_MAGIC, 19)
>  #define PTP_MASK_EN_SINGLE  _IOW(PTP_CLK_MAGIC, 20, unsigned int)
> +#define PTP_SYS_OFFSET_ANY \
> +	_IOWR(PTP_CLK_MAGIC, 21, struct ptp_sys_offset_any)

As I said before, this functionality really ought to be a new system call.

Did you see these patch series posted on the list?

 31.Dec'23 Sagi Maimon          [PATCH v4] posix-timers: add multi_clock_gettime system call
 31.Dec'23 Andy Lutomirski      ├─>
 01.Jan'24 Sagi Maimon          │ └─>
 01.Jan'24 kernel test rob      ├─>
 01.Jan'24 kernel test rob      └─>

 02.Jan'24 Sagi Maimon          [PATCH v5] posix-timers: add multi_clock_gettime system call
 02.Jan'24 Arnd Bergmann        ├─>
 03.Jan'24 Sagi Maimon          │ └─>
 04.Jan'24 kernel test rob      └─>

I think this will be the way forward.

Please review the multi_clock_gettime series and help refine it.

Thanks,
Richard


