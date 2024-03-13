Return-Path: <linux-kernel+bounces-101331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3253487A5A6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8B328322A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75F339AC5;
	Wed, 13 Mar 2024 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qbZ8L7sU"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F1439854
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325067; cv=none; b=GUc08+RWzTa63iTHnaaP2Aq35p6fvsG2aZPm2xNOacE0m4/CGUvu8uqUBC7nieGiqsbHXQ8/uHzHfjiGyS4qIj7tnSLOGMFIsr9GhDe28G7+8SOZzuiLsYwm6dRNdD6fGwWphUegqzvLJRJaIX2MDgwMAWSzmpUP327YzDAEgm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325067; c=relaxed/simple;
	bh=LoZmgljt+ac9BD9RLPwH0JEFx6pL0A4Uz+wUw5jJROg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzSCRUFxsw07+3O1F9NSw3oNfUGjms3xGSEeEQdq712WHJyE1oYzR7nJw/KtFSvbwpTBKkOzByrto6GMX98t7TPwXNNE+ambk8NV9iEvWnrG+hkvzJ8qKzyO50SdfKkRZG8MHeq79zkOFKZkFowAJrnICV3rgaTMduwq2ZWFvmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qbZ8L7sU; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5684f95cc9bso1250025a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 03:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710325064; x=1710929864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5M/ORIq4sCwrmX5HQhBLxTr5aGDowKuZzCR4YxxCzO0=;
        b=qbZ8L7sUteG8qGFCesLSaeGOQvUfqLXaCHAq+nFICfwJ6XJgtQJibF8bOPDcHnNuc9
         B4egiWvgPXWQ7P3psKbfLwLenSptyvo3hI9S0btEgAZPf9pabYeSN+LJWwWjMWylQcZq
         dVczIWgP5BAHaX3NKBvKB2vQpIhvaEWvOZn5xFMmdtv1e2nj45eB7awrJp/mJ1r7D4eT
         sMLa0c096rh94KFhcZrxLjjJBI2ghAzb3QBvbFPN2sWHqJxbRmHOIuwmTqNQ7DOP9ZmS
         +y7eUG8vIkprH3uhrEs2+MF8z0tLKpdtqR3tOfGiZ1e+mSmX3c9TKMP+D2BHwkl8SLLF
         GsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710325064; x=1710929864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5M/ORIq4sCwrmX5HQhBLxTr5aGDowKuZzCR4YxxCzO0=;
        b=rC10evMG21k6zH9J54/kvee38a2zYED8Tjy2CoaKi74KEzsl8dbkbbpuYvelwL8leC
         WjLy443EPmtk2yO8mucqyQZDswdK6f6fez2fCtUKgnF757/DTF+YFq9jZj1TsuV9V/FM
         OEms2crF77b1NZziGuG/qA22Pqq660AL8U8IgSkMyTPR6Z2Peg324+QYTDWV9JnrvY8r
         OoRKTU+Z2Fw3pJNLMW1oA94wYNwoyzFNJynRqeH/Hz1bd6eAATA0u1+IQ3qWmjGq32T7
         G/Y96E2+fPm4ZJMAwdERcBz6DdpGWzhw6wEcdnj4CVOn06HNrew9GQcky3X3g0dQCYIG
         nwTg==
X-Forwarded-Encrypted: i=1; AJvYcCWKdYmmv7wcwERIhbrRjYAoNFd5xnqB93r/LqPQen96mOhESmIqOIrcqBotNyah7AAKKFXNQ7vOKO11SMYvSCUMelm9mUrm2m3+welC
X-Gm-Message-State: AOJu0YwaM4279Gh4cl/MVFW/cWFZV362A/mzzyrIhW2lL0zFArzG5GI9
	EVofPqNwVj8rruAI8TLMw/NadQmmI/NUc/0Jv2XmDI9Q5nYczWDjTOBvkvl477k=
X-Google-Smtp-Source: AGHT+IELGqN8dTVBTo97+SZdGl19AlZq/47XPA/TYt/B825Pkr/QYywCASzMf86GH0N80ToFdcXSGQ==
X-Received: by 2002:a50:f619:0:b0:566:6b3e:c965 with SMTP id c25-20020a50f619000000b005666b3ec965mr2314303edn.4.1710325063594;
        Wed, 13 Mar 2024 03:17:43 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id fg3-20020a056402548300b0056889f3cedfsm316920edb.55.2024.03.13.03.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 03:17:43 -0700 (PDT)
Date: Wed, 13 Mar 2024 13:17:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Prasad Pandit <ppandit@redhat.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
	rjui@broadcom.com, sbranden@broadcom.com,
	linux-staging@lists.linux.dev, linux-rpi-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v2] staging: bcm2835-audio: add terminating new line to
 Kconifg
Message-ID: <0a1aa580-50b2-4657-8308-94bffb194aea@moroto.mountain>
References: <20240313091259.1413854-1-ppandit@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313091259.1413854-1-ppandit@redhat.com>

Normally, I would let Greg decide to notice or ignore the typo in the
subject but he's on vacation...  s/Kconifg/Kconfig/

On Wed, Mar 13, 2024 at 02:42:59PM +0530, Prasad Pandit wrote:
> From: Prasad Pandit <pjp@fedoraproject.org>
> 
> Add terminating new line to the Kconfig file.

Why does this make a difference?  Is it just because it's annoying to
cat a file that doesn't have a newline at the end?  I checked, and it's
not a checkpatch warning.  Perhaps it should be though.

KTODO: make checkpatch.pl warn about files that don't end in a newline

Since you're resending anyway could you add that information to the
commit message?  Something like:  "Add terminating new line to the
Kconfig file.  Otherwise it's annoying to cat files that don't have a
newline.  #PetPeeve".

Just fix the subject and add a line to the commit message and I'll ack
the patch.

regards,
dan carpenter


