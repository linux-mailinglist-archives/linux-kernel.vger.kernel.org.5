Return-Path: <linux-kernel+bounces-12481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8007181F56F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D17DBB213FC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70225253;
	Thu, 28 Dec 2023 07:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="lJQK0Fmp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108B14402
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3f2985425so22996475ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 23:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703748230; x=1704353030; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TS3IlhabUMeMhlcESxYLb6eSGYrLYo3Ig5rpjdUNeg=;
        b=lJQK0FmpkI8IBwp7sozilAKZY6DXtsPivugsxbL7VXlZSGJK+vtTorKMVMOUYqvGiH
         X38kRqOYMKZCAStleVnlAR2EV8st3Zh29pBgVOpnc3JI96Ex9MgQ9FKLNWk9etPRg5sf
         bQhh4m4rpiAh1NMs/YvghXiM+Ug/ffBH8zJV+sIufHxXlJXpBoheeH8ZuQVNDLV9Wxxe
         7Mo2hkhDSAQL/YRhB6Xxk4zFVXYLizyAvtACLHNgruUa0eSpQ8QCE2SSW/5XXu9UDHcw
         o2VQA5ptEaxirBZ+7WuNc58h5gC+WydZTFuyvil5hz8i+RCSdGrLgB0fJ8RlWbAC0rHm
         Cz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703748230; x=1704353030;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TS3IlhabUMeMhlcESxYLb6eSGYrLYo3Ig5rpjdUNeg=;
        b=NbJDp26rOQ6q1G2AiyOugV6CKVfKqiD3AR1b/QZdz/ggcCQjiloCJShOrLIkGSFyCQ
         dbvhNoGAtKktCqFXAMfi/E3gRa769m5NL5sH2r8n6pCNBcFMSi0q6n7sXYOLnDHZZGu5
         ttv4JvYs0mLLSyqVpTlYODV35k6LnCYGoThhMulIILu5dUWdyfTicskvIHsw78geMuj0
         40Zd2JmjiIdWljznDYMBt+fMa0FP9lnu0HOQHWYzCvcTByNWJF6CD/dd/9pe1BrfuYwC
         DwQEkJ9N8Y14oXKbJtCNhwhNwe2J1sQeU9mxGiUYFUSD/l4l0IL8entfU89Y0PVqC39P
         2ZIw==
X-Gm-Message-State: AOJu0Ywg1Pm1dErhqEd3KCTrTMLFCZ8pM9BJOFQlgTF+rpBmpIkza3ei
	nwgANmWTQSXyQyyKwyNaLvC6t0j16GSSAw==
X-Google-Smtp-Source: AGHT+IFyvLhzXFMJ5PbTZF/J8a62bVgxOg0ZB1uWE0WCuQw5a65QLBUpvBTSD0CYPdtp0b15f4cSuw==
X-Received: by 2002:a17:902:c947:b0:1d4:3b8a:639a with SMTP id i7-20020a170902c94700b001d43b8a639amr2994233pla.124.1703748230281;
        Wed, 27 Dec 2023 23:23:50 -0800 (PST)
Received: from smtpclient.apple ([8.210.91.195])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902ea0500b001d45f92c436sm6347479plg.5.2023.12.27.23.23.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2023 23:23:49 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
From: Li Feng <fengli@smartx.com>
In-Reply-To: <20231227050544-mutt-send-email-mst@kernel.org>
Date: Thu, 28 Dec 2023 15:25:10 +0800
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Jens Axboe <axboe@kernel.dk>,
 Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9679B268-5BD7-4731-86CC-6B5CF7CE2DF2@smartx.com>
References: <20231207043118.118158-1-fengli@smartx.com>
 <20231225092010-mutt-send-email-mst@kernel.org>
 <AB23804D-FF38-47B8-ADC6-C0A19B7083CC@smartx.com>
 <20231226103743-mutt-send-email-mst@kernel.org>
 <2E148FC5-F9A9-4A86-99F1-8D0B93412181@smartx.com>
 <20231227050544-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)



> On Dec 27, 2023, at 18:06, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Wed, Dec 27, 2023 at 03:26:30PM +0800, Li Feng wrote:
>>=20
>>=20
>>> On Dec 26, 2023, at 23:38, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>=20
>>> On Tue, Dec 26, 2023 at 05:01:40PM +0800, Li Feng wrote:
>>>> I don't have ideas right now to answer Christoph/Paolo's question.
>>>=20
>>> Paolo did some testing on this thread and posted some concerns.
>>> Do you disagree with his analysis?
>>=20
>> Paolo gave a very detailed data analysis. Indeed, in some low queue =
depth
>> scenarios, the data dropped somewhat. However, I suspect that it may =
be=20
>> caused by other problems (such as test fluctuations) rather than the =
benefits=20
>> brought by deadline.
>=20
> Maybe. I think it would be up to you to prove this then.
Ok.

>=20
>=20
>> BTW, I think 128 queue depth test is a very important and common =
performance
>> test item for storage devices.
>>=20
>> Thanks,
>> Li
>>=20
>>>=20
>>> --=20
>>> MST
>>>=20
>=20


