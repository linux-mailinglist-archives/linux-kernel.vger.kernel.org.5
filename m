Return-Path: <linux-kernel+bounces-18402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1B7825C93
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77341B22BF9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0216E36094;
	Fri,  5 Jan 2024 22:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=automattic.com header.i=@automattic.com header.b="EwP7MPMT";
	dkim=pass (2048-bit key) header.d=automattic.com header.i=@automattic.com header.b="GJA8rH2b";
	dkim=pass (2048-bit key) header.d=automattic.com header.i=@automattic.com header.b="SbOoYEzn";
	dkim=neutral (0-bit key) header.d=automattic.com header.i=@automattic.com header.b="desECVhM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx1.dfw.automattic.com (mx1.dfw.automattic.com [192.0.84.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BF01E4B8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 22:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=automattic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=automattic.com
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mx1.dfw.automattic.com (Postfix) with ESMTP id 07E351DBD9F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 22:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=automattic.com;
	 h=x-mailer:date:date:message-id:subject:subject:mime-version
	:content-transfer-encoding:content-type:content-type:from:from
	:received:received:received:received:received:received; s=
	automattic1; t=1704494742; bh=Up0N2D2TIaUtZ5vQ4loBRKY+1p4GysHJOj
	eboZtOiRk=; b=EwP7MPMTdgwLatdLmdDcLcWt1VQvK1poEvvzKytpJRZM8b0D0a
	HLYr6qfs7tF28BY/F7A94uzBItUXNT36TfD+zqHtO1PYAHunnNfk9Ge7Mnp6g9P2
	KA8U3VtwOPzlmojA2epAFegZJCuZ1ySxV/WM5p2c25o2mAKr5DqTdlUShU8A4CR7
	5NjZcZ6XE8oWayJseyXcOgP9Wp8hRi94JYMu0x2ixbqUJPpA0f9HFGov30LXtTiz
	1OUG7jFfSiGGw3chBRPJbNfXdhBZDorlTtje+VHbzYsAH67BPJjFci5UMjshVsYy
	lEFO1ISNArDEStTx3xwRxDwSBaLljaN6jARA==
X-Virus-Scanned: Debian amavisd-new at wordpress.com
Received: from mx1.dfw.automattic.com ([127.0.0.1])
	by localhost (mx1.dfw.automattic.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RMYjP-64BY1B for <linux-kernel@vger.kernel.org>;
	Fri,  5 Jan 2024 22:45:42 +0000 (UTC)
Received: from smtp-gw2.dfw.automattic.com (smtp-gw2.dfw.automattic.com [192.0.95.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.dfw.automattic.com (Postfix) with ESMTPS id B6A751DBD9E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 22:45:42 +0000 (UTC)
Authentication-Results: mail.automattic.com;
	dkim=pass (2048-bit key; unprotected) header.d=automattic.com header.i=@automattic.com header.b="GJA8rH2b";
	dkim=pass (2048-bit key; unprotected) header.d=automattic.com header.i=@automattic.com header.b="SbOoYEzn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=automattic.com header.i=@automattic.com header.b="desECVhM";
	dkim-atps=neutral
Received: from smtp-gw2.dfw.automattic.com (localhost.localdomain [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-gw2.dfw.automattic.com (Postfix) with ESMTPS id A7420A03D9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 22:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=automattic.com;
	s=automattic2; t=1704494742;
	bh=Up0N2D2TIaUtZ5vQ4loBRKY+1p4GysHJOjeboZtOiRk=;
	h=From:Subject:Date:To:From;
	b=GJA8rH2bFcClKBh12J+aJkIJmbiA31/IDuPvimUwfmpA29bMq294mMJ6WxzeOFVtM
	 IANM0p2RB3xKLX12LqqcgOyKvHEc2tN0gx14m/bpQwIPo29br3riD0SPvpQ1shvd/u
	 Y6xQiD4y4lVkaAAjz70X7RSmu1kk29vYL7eJ2dui3yLqCK7fg3ot0czdzSs6u6nLFt
	 Xb3SwWd2Y35qgoWc5ac7pSuopUr9fjNecqoXb+8c58pb/m5kD8RDvz0FPRICED3h96
	 XZYlOauopDtWCx0cKgZpGMFBEL39XHeKISqjjCo/wgqCHADJnBeC6JhWHXS1iu40/c
	 +bA5UMlg8mt7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=automattic.com;
	s=automattic1; t=1704494742;
	bh=Up0N2D2TIaUtZ5vQ4loBRKY+1p4GysHJOjeboZtOiRk=;
	h=From:Subject:Date:To:From;
	b=SbOoYEzn+pgXP0xusJpIEVNPxO4bNHWma7QwvD+wcVF/L3Elj5qVSUA6nWgidBk8b
	 +eTw5Vpcrtl2nja06eyx2boj2faNDlkXACEfX6dYSBn3PGmMxyJqE4GPiQY4Wk4SkF
	 Ec0OHhHR+2br5niVG2Yv9UA4KVlaAIJAgj6u8hGYWXjwlr6H1CIdhIrBIkJTicb7oc
	 N40kXoA2jSRNnDcsM+9rp2M/xCJLNX7x27XEyQvAn60a7Sboc0zo7G2EkaKFIiunGg
	 drEloAZSxFIW5FzeICDoMRXp6N39+ZPQpGiq3LWk95mf8lirClJoFsNdcXjHBkCHVi
	 4o2No7opuyWHg==
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-gw2.dfw.automattic.com (Postfix) with ESMTPS id 97945A02FD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 22:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=automattic.com;
	s=automattic2; t=1704494742;
	bh=Up0N2D2TIaUtZ5vQ4loBRKY+1p4GysHJOjeboZtOiRk=;
	h=From:Subject:Date:To:From;
	b=desECVhMC2F1bagGQZT2fZYc3piMjsXzV2PbbVK29xd9Y3i3XfK2HvkU7qyeddfGX
	 2hdzhlq1XTPkyxs4U1Tb8ImMjExgG1BdMVb6VwC6+y/bRlSHeaWI12vyCMbFIUzca2
	 ZwMPcOadT8eaIqvkhitBRaNcLpLqCiu8w6j1pM801JQ5wsB+WJ/YQPmYLcUJgMc/07
	 59HxngHfFGl6zmurD/UuY9WfEuZRL6FP00mkjNHcs691NhVGDJQtf0YhYRIvoGefXa
	 uTJWDeQOzsLddghKjQ8mHbTL4f9mG9PFgWOnJQINtJNaRBLRupurIyl4aFF3hK0uGI
	 D+74yp6TM5fQg==
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33688aa4316so32828f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 14:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704494740; x=1705099540;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ikQDiPyG7zvdjFhCRKhe8GvmQ7gT04TnluWIutkJHQc=;
        b=nHGnguTuL3sXYFdvlRkVnMyn9ARbx0aNjwwmuSygNj6EKrO/EZ0Twg0+VEmkhtoTMW
         Mze5ghIE4+KTHYNv+h+XZBT53GyowDAwxVF3HBFxkc8c7poXSKudEvnWSXwaOOXuHMnr
         71s2wIJyTcamQfKPdf2573oiBFthUsVZHykeX1Ul6FwqB2LH18nlK4ZM8hweMPvD4pbu
         gtN9v3FsKFAZLa8AVDJOcD8LGzJ8d3PS+QW1umW+fANnj6eu+vQOkrKNXTmKsJNUnFIF
         Xn8IWgnKohepHl3HFEtD0K/jCao+Yl0absdWmezaqmnZZUCHJNoeY6408tB2BDjCfJE7
         KrjQ==
X-Gm-Message-State: AOJu0YxDVrR8WHtvcBsvcegkrcWWsQ/Gh0vjMioedUcj+ty8NshNoIa7
	VVpAdX0mzvuCJHSOheTkoFAB6+669o3ObBVKZQZLT1XFIYHe8ZUnU3WEOTZw/wx2sO7ZNt22Oto
	LZ660eti+fnxuK2VordLPq8bziCkelz/HrGIXhkmY
X-Received: by 2002:adf:f6ce:0:b0:336:787c:6236 with SMTP id y14-20020adff6ce000000b00336787c6236mr50055wrp.65.1704494740689;
        Fri, 05 Jan 2024 14:45:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHk4NO8L5czZuzxTklW9FuZ7NDCE9Rf0p2o3mJVQWpxW9AfFPoi0sRklDy68MESyWt37rFIMg==
X-Received: by 2002:adf:f6ce:0:b0:336:787c:6236 with SMTP id y14-20020adff6ce000000b00336787c6236mr50051wrp.65.1704494740281;
        Fri, 05 Jan 2024 14:45:40 -0800 (PST)
Received: from smtpclient.apple (2-234-153-233.ip223.fastwebnet.it. [2.234.153.233])
        by smtp.gmail.com with ESMTPSA id c3-20020a5d4f03000000b00336344c3c3fsm2149944wru.90.2024.01.05.14.45.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jan 2024 14:45:39 -0800 (PST)
From: Ale Crismani <ale.crismani@automattic.com>
X-Google-Original-From: Ale Crismani <ale.crismani@automattic.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Performance regression in ip_set_swap on 6.1.69
Message-Id: <C0829B10-EAA6-4809-874E-E1E9C05A8D84@automattic.com>
Date: Fri, 5 Jan 2024 23:45:27 +0100
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3731.700.6)

Dear all,

When upgrading some of our Debian hosts that compose a Kubernetes =
cluster we found a regression in ip_set_swap on 6.1.69. Calls to =
ip_set_swap now take roughly 15ms, while they used to take just tens of =
microseconds before.

The issue is very visible for use, since we use kube-router as our =
Kubernetes networking interface, and it uses ipset swap all the time to =
populate sets that enforce firewall policies between containers.

We tracked the issue down with strace, and then took stats with bpftrace =
running:
---
kfunc:ip_set:ip_set_swap {
        @start[tid] =3D nsecs;
}

kretfunc:ip_set:ip_set_swap {
        if (@start[tid]) {
                @srlat =3D hist((nsecs - @start[tid])/1000);
                delete(@start[tid]);
        }
}

interval:s:20 {
        printf("ip_set_swap() latency, milliseconds:\n");
---

On 6.1.69 results look like:
=20
ip_set_swap() latency, milliseconds:
[8K, 16K)           1848 =
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
[16K, 32K)         1017 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@
[32K, 64K)         38     |@

while on 6.1.67:
ip_set_swap() latency, milliseconds:

[0]                  166   |@
[1]                  378   |@@
[2, 4)              762   |@@@@@
[4, 8)              1624 |@@@@@@@@@@@
[8, 16)            3493 |@@@@@@@@@@@@@@@@@@@@@@@@
[16, 32)          7308 =
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
[32, 64)          6412 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
[64, 128)              1 |

We tried compiling commits between 6.1.67 and 6.1.69 and it seems the =
performance regression was introduced by 875ee3a, ip_set_swap is fast on =
602505 that precedes it, and slow on it.

First time I post here, hope the format is appropriate, and thanks for =
any help with this! Also, if possible, I'd appreciate if any reply could =
CC me, as I am not subscribed.

Alessandro Crismani=

