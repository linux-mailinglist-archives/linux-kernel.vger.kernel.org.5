Return-Path: <linux-kernel+bounces-98640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0E0877D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8261C21040
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69F61A27D;
	Mon, 11 Mar 2024 09:43:20 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA2317578;
	Mon, 11 Mar 2024 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710150200; cv=none; b=I1LoDMYP03jvHGgzOCRDHHx9rW+qybloOsKw0fkCuGECudYgioHddSIRhEeAKiQsQD8ck0SYJqYSY30jnsGUrWK4or44TLOpqdCPV1ZLnITZepu+RAQr9WD2pDADF8Mq3TyulHyPY/2wNBIUXkdxu2JxbIwqRRU37CrUMOR2ZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710150200; c=relaxed/simple;
	bh=ntKFM4IAn00AoGiPHpx0tEZsUtien5xXsLMyxO2C2Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELhbYIuhN0zVzpl+QZDRLu/zmHcaSyrDDlv2LHca8EseDoHNVQ7YRfF7F/GPBkQ7aGp3PDwemr82d4TNtObF7+8YirVdwjkVFVnEVj2mPQIRTWO75uYKDQUp2RIHYOl2w7OVDMdhIqvp/lJHWZjsyUWqHGHWNAHMltiG7PyYJko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a45fd0a0980so199977366b.2;
        Mon, 11 Mar 2024 02:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710150197; x=1710754997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSyrdXqp3jtgY6jvF/E2QaWM25cbVZ+h2KPhZvu2LP4=;
        b=PrkKnFMJVgYdhjtK2G5h/bmOY4USE1QDuXnPi3Ki6FOkGHL99EM7B8IBg/ZftzliOg
         zA4DDNMRkWU4RszCZh86YgGykiGuuUO5qf9g3fJ7ytZJEXqCQcudV/UmphTNiaLvTYZf
         tCTr0+qPnV67B/53ENiCkrZDD1z7TwTY8MKrBwabFs+QAMsEPMoxgEibMxNql4VOa+Gn
         TWjh70/RG8ugUCAar2tVEyxA6NvH+YYWeNVmtGuLBF7oL4ABzPdCvj64Zugannyxecfl
         Bu2uhH0PWHpV3tXsPpzRBngGp2ukkWsircg4TszeqfykigoZaAgC6NxjHjO622jbXSIb
         QouQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA1HPwMwo+2hZ17aeq4qX+Gy/qXWwc+W6qC6VT4kIgQvon8r6TFPCZ9oo0mNOGJ5FiSXPYq3Q2yVLWeyx0Wlz2NPGHsa4RzNruAg5+S5MmadPdlSJy/lJr2nWURv3AKvgG3kw1ON5RfNE4A4xR6nF1Ea8RgtTgIk3MtIECWJiQ
X-Gm-Message-State: AOJu0YxSoguUXit123BKrePJLS2VpsVyNaSVZkH88YSw62+5VDrs8c4B
	NO6W/EikBGQWT0biMY8L4s2ZH0TT3qqIsOhFcUmyqnSVhuLsN9Jj
X-Google-Smtp-Source: AGHT+IF6mW6mi/T1LUxRvaBKxnf41VSHh5CktQtafSrWqGE0tuEakBbKqJRCognliCboXprZYrQimQ==
X-Received: by 2002:a17:907:97d0:b0:a46:2c70:2226 with SMTP id js16-20020a17090797d000b00a462c702226mr1178381ejc.56.1710150196726;
        Mon, 11 Mar 2024 02:43:16 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id se13-20020a170906ce4d00b00a45a8c4edb4sm2676520ejb.48.2024.03.11.02.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 02:43:16 -0700 (PDT)
Date: Mon, 11 Mar 2024 02:43:12 -0700
From: Breno Leitao <leitao@debian.org>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: netconsole: Add continuation line
 prefix to userdata messages
Message-ID: <Ze7SMBzfaNP41xcO@gmail.com>
References: <20240308002525.248672-1-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308002525.248672-1-thepacketgeek@gmail.com>

On Thu, Mar 07, 2024 at 04:25:24PM -0800, Matthew Wood wrote:
> Add a space (' ') prefix to every userdata line to match docs for
> dev-kmsg. To account for this extra character in each userdata entry,
> reduce userdata entry names (directory name) from 54 characters to 53.
> 
> According to the dev-kmsg docs, a space is used for subsequent lines to
> mark them as continuation lines.
> 
> > A line starting with ' ', is a continuation line, adding
> > key/value pairs to the log message, which provide the machine
> > readable context of the message, for reliable processing in
> > userspace.
> 
> Testing for this patch::
> 
>  cd /sys/kernel/config/netconsole && mkdir cmdline0
>  cd cmdline0
>  mkdir userdata/test && echo "hello" > userdata/test/value
>  mkdir userdata/test2 && echo "hello2" > userdata/test2/value
>  echo "message" > /dev/kmsg
> 
> Outputs::
> 
>  6.8.0-rc5-virtme,12,493,231373579,-;message
>   test=hello
>   test2=hello2
> 
> And I confirmed all testing works as expected from the original patchset
> 
> Fixes: df03f830d099 ("net: netconsole: cache userdata formatted string in netconsole_target")
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.rog>

