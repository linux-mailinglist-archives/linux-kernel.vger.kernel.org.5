Return-Path: <linux-kernel+bounces-65081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5D985478E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E676E1F20632
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3E4199AB;
	Wed, 14 Feb 2024 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="1COWNVYH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nsQklX3H"
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D3118EA5;
	Wed, 14 Feb 2024 10:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907896; cv=none; b=J4USBJyHlVbWJ23QtFKRbm2rN/gb9aZ3X23iZkynqNnK3l8g5TyIw8ySQxWQpBpQEdv/jHqk+cg97gMUMPRMoY54yifk8l6CCnKszseVU1XUnrwIjgpu/b7xk3xoRmNVBNdT5Yy0pl5xMPcGlhaVetKTTe0V8E89msXD/HA+EUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907896; c=relaxed/simple;
	bh=IKPjU6JepByQUbY4d+KvU9UgItGzStQnpzqm2BCTHvQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ued2m7SFCLnmEcrHAOZCxFzeQobAQAFUC44dTlQVkof+9P4zSm0jSnv4uuK3VwVgWNXY8k0CgODgF4CujOU4N0pHBeA+G1sk+lAKP7iSRm8yl1ZQnqTVYVc/uNLx69oEsxcOQRXtk6j9OchlrsxhoJ2MpVSJKrnDCg4CnQxjmlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=1COWNVYH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nsQklX3H; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 9F5901C0007B;
	Wed, 14 Feb 2024 05:51:33 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 14 Feb 2024 05:51:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707907893; x=1707994293; bh=79/Qzm2vJk
	0BAzjRMVt7ecM1kUIJeCMDLpwDD4uxJWo=; b=1COWNVYH87gWNKMltpLJTnWw29
	E25ubIUcUwoHblWcT8XhX6017jq8mggn+2LzFzRLZizNfrUHM5fMdHu8tdqOUtbR
	Rut6m5DVGdTIAhwrtJtiuEGiWiyL/Sn8YqBDXndFO1YVxtyVzwtduSf3+6Fmo8Pl
	o5lCb5tnI5yfyyJMTUBjW4EJvcW9hwZeXVMifZy40bJDlrJxz5UGkSedmePUqTDD
	/E8PDeBP6vWghx6RKjgf2T9ZIDD0lVy8SQIjlVI3Qfol8hDi8E21vfT450NPVdkV
	q6qwj/uYa4tfVjt15cWHWMSFlXTaCdyjGXAwrYdUwq2sQCI9yHq46EHdHGJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707907893; x=1707994293; bh=79/Qzm2vJk0BAzjRMVt7ecM1kUIJ
	eCMDLpwDD4uxJWo=; b=nsQklX3H59Y1ufjMGSGzYWPK6jQicRXM1irJ7KW5dOEn
	yrQqdBhVESERXan/LkmJC7udmsuLmsLbGKrWRj5lsghVKDce2g+jq6LpYSb83DTu
	XvrY5b9vyAPAZxbNJZoadCu5OBx0RIyJth9xjpAwXPkzTHhK7IgopNm55Tw+Gd5l
	JzLxf5kFU5aY1KLLVBAlwzz4myfew2tSsHFCgmi3nBri7c/bYSYlT8SzhmeWfO+w
	+FqaPnAMbvODLnUyKD9LY3U+uT9xs4Qjc443xRytGv7ZwFLLZrsvTKdiVsFqZYYK
	0hmutfFuGrnr43rBfyihzXpYE+WEzR5M4Tie+msl2A==
X-ME-Sender: <xms:NJvMZYfsglnlEUxKurnhugeyEfdV54TEHGsGZkqh_shNIhg2nSGxLw>
    <xme:NJvMZaMbqiNeRXCSSbQieaooADEKvUtW1QoASI6QwH5mkTFGzqA2_ExsCiZPnUdU2
    96TSMRWpb2mcIZDezg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:NZvMZZiO5s_YjRzHQwE-h9yArVo-ZuFoSiP1JR6yGT4YOFzkCsaqqQ>
    <xmx:NZvMZd-ySjK4kgFCrJNikAQ7HJXyrUmYA1-h4n6hTkBM-BKSn2RC5g>
    <xmx:NZvMZUtHWgpkqZYz4Un54ZvXVuK4Ca_5VcICfU9iaGS2hJiHELoa6Q>
    <xmx:NZvMZVlC3VMgFqiA2sblIvjIjZ66Lo2oqeswXAyrJvNbcXvRorc6nj8D8YA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D6FFBB6008D; Wed, 14 Feb 2024 05:51:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d9a7ad2f-c9a7-4886-8bbc-7a77771c0aec@app.fastmail.com>
In-Reply-To: <87plwze34l.fsf@kernel.org>
References: <20240213100912.459018-1-arnd@kernel.org>
 <170790025305.3179441.138152315558305278.kvalo@kernel.org>
 <08ac32ef-610d-479d-a3fd-a3c3b8c4c697@app.fastmail.com>
 <87plwze34l.fsf@kernel.org>
Date: Wed, 14 Feb 2024 11:51:02 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kalle Valo" <kvalo@kernel.org>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Jeff Johnson" <quic_jjohnson@quicinc.com>,
 "Karthikeyan Periyasamy" <quic_periyasa@quicinc.com>,
 "Aloka Dixit" <quic_alokad@quicinc.com>, "Wen Gong" <quic_wgong@quicinc.com>,
 "Muna Sinada" <quic_msinada@quicinc.com>,
 "Aditya Kumar Singh" <quic_adisi@quicinc.com>, ath12k@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: sanitize ath12k_mac_allocate() return code
Content-Type: text/plain

On Wed, Feb 14, 2024, at 11:44, Kalle Valo wrote:
> "Arnd Bergmann" <arnd@arndb.de> writes:
>> On Wed, Feb 14, 2024, at 09:44, Kalle Valo wrote:
>>> Arnd Bergmann <arnd@kernel.org> wrote:
>
>> but I see it's not in linux-next yet as of today.
>
> Yeah, it's a problem that ath.git is not included linux-next builds. The
> commits will be in linux-next only after ath-next is pulled to
> wireless-next :/

Not sure if that is intentional, but if you'd like to change
that, you can just email Stephen Rothwell asking him to include
ath-next into linux-next as well.

      Arnd 

