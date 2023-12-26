Return-Path: <linux-kernel+bounces-11425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2D981E615
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC20282F03
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244154CE09;
	Tue, 26 Dec 2023 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="smS/NLG+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57294CB50
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d9bf6f24f3so98663b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 01:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703581219; x=1704186019; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciIW1eEWiX3+BIMc+04M65OlmBRBFOwzSxY74rwr6UI=;
        b=smS/NLG+6bn00x5WgPNHxfF8B0d+ThtCgqLGTwW9z9xaqyM+smbh2H20g67KuN4FwS
         DyCzJEndMfL2E2hKVj+PtI81KkLG4d6NBdXWmW0IbvbSk2bBKO0jdf8uAIJ2yJcLVkcw
         3kaMvGhlGe4IcPG0QZon7YpZRZNmshniMSeX/lfEnZKxglfUe8ehn1SYIEI91LGsFHRW
         gr3b6fP/ioU0CdyXAqgFCmnBvckoSZcDsJJeDjlLwIwdwtW8nMYP/DmGf9V1CoAU4aCo
         SGIgTovSLn4K9/lbHrVRNkL4fm/U+nx4tH7l/GK/Oe81ge5hlpQ/SzTrMqd91XwAlPqR
         3tag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703581219; x=1704186019;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciIW1eEWiX3+BIMc+04M65OlmBRBFOwzSxY74rwr6UI=;
        b=wdsIY4x/VfnxmzMhLbB0bEWhGZYK7pS+BOYbp5GBWfB8F/dSEQ464Syihdx6zwNxyT
         QUCXCX+ucdF11BUgJlCxhzP8x73mLP/1w8swCoxiOYBNqnc68uuBJa9m59fOIGfi8Hjw
         V8VXTjISVpg3nA1AHQjvYxnxT5ugRf7zRVfQ1CyxZEmJKoNu3x1uwWPXolw1EZNANblS
         jRUmj+VGbERjVYC7+YQDZPL6vHZBOu4auLOajAglcK1nUGpiq+umcGjtv8d3MBdT/a/m
         UiaksllDYisk1eJuX4xH03kgcN5hl/OkobjLaWJCHvqPsMvlYQrjDH9IntDPTFijI0kj
         JaQw==
X-Gm-Message-State: AOJu0YyAkvyzroKrU4NzzpXh5jBytY9JCmzXs85PQr3LsE9MinSy3Q9L
	n3HWwe526fLGbCvWbPjTOGa50254qyqh2A==
X-Google-Smtp-Source: AGHT+IFo+TlFAxPGIaMC6ckFkREHygYopoFgva5SosFYSHy9AdgjsN5p/YSOefLrWKS6+ubequg+uQ==
X-Received: by 2002:a05:6a20:2714:b0:195:3520:632c with SMTP id u20-20020a056a20271400b001953520632cmr1638097pze.15.1703581218306;
        Tue, 26 Dec 2023 01:00:18 -0800 (PST)
Received: from smtpclient.apple ([8.210.91.195])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b001d05fb4cf3csm9567645plb.62.2023.12.26.01.00.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Dec 2023 01:00:17 -0800 (PST)
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
In-Reply-To: <20231225092010-mutt-send-email-mst@kernel.org>
Date: Tue, 26 Dec 2023 17:01:40 +0800
Cc: Jens Axboe <axboe@kernel.dk>,
 Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AB23804D-FF38-47B8-ADC6-C0A19B7083CC@smartx.com>
References: <20231207043118.118158-1-fengli@smartx.com>
 <20231225092010-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi MST and paolo,

mq-deadline is good for slow media, and none is good for high-speed =
media.=20
It depends on how the community views this issue. When virtio-blk adopts
multi-queue,it automatically changes from deadline to none, which is not
uniform here.

I don't have ideas right now to answer Christoph/Paolo's question.

Thanks,
Li

> On Dec 25, 2023, at 22:20, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Thu, Dec 07, 2023 at 12:31:05PM +0800, Li Feng wrote:
>> virtio-blk is generally used in cloud computing scenarios, where the
>> performance of virtual disks is very important. The mq-deadline =
scheduler
>> has a big performance drop compared to none with single queue. In my =
tests,
>> mq-deadline 4k readread iops were 270k compared to 450k for none. So =
here
>> the default scheduler of virtio-blk is set to "none".
>>=20
>> Signed-off-by: Li Feng <fengli@smartx.com>
>=20
> I dropped this for now, pls try to address comments by Christoph/Paolo
> if it's still needed
>=20
>> ---
>> drivers/block/virtio_blk.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> index d53d6aa8ee69..5183ec8e00be 100644
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
>> @@ -1367,7 +1367,7 @@ static int virtblk_probe(struct virtio_device =
*vdev)
>> 	vblk->tag_set.ops =3D &virtio_mq_ops;
>> 	vblk->tag_set.queue_depth =3D queue_depth;
>> 	vblk->tag_set.numa_node =3D NUMA_NO_NODE;
>> -	vblk->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE;
>> +	vblk->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE | =
BLK_MQ_F_NO_SCHED_BY_DEFAULT;
>> 	vblk->tag_set.cmd_size =3D
>> 		sizeof(struct virtblk_req) +
>> 		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
>> --=20
>> 2.42.0
>=20


