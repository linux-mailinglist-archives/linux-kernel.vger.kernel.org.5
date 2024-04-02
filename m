Return-Path: <linux-kernel+bounces-127329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A972E8949D8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3A21F23339
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F2815E8C;
	Tue,  2 Apr 2024 03:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="QyQLpEKr"
Received: from out203-205-251-84.mail.qq.com (unknown [203.205.251.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E35D1426F;
	Tue,  2 Apr 2024 03:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712027351; cv=none; b=B9naIzgQimRgiEZHverHQzpgv31AQwwCZD8eDV1n+4trf8IVUeDhKFTuK0G3lG9zoQ1lwf3n7uRJ3mP4cavdiFDgPTcTiO3kBegNTaFO2LmbI4NAlcTWFd22QD89SblamcA+OMWUQ6J+B+FDrHi8cFwmN53B2Cx3MABHjDa0OAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712027351; c=relaxed/simple;
	bh=jq7gceLVPX+zUUkhBft5MXInIaSdwizfVP5WkNn2F2I=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=tt5aOPuQJHwgsWkPziPp7rE9/bnJVCxHrMg94ae9sVCVC//ijk3x+1KCpYt6bOkAVy/rtQDGZ+NF2HLj0nwh8ahzH+Kp8GmsIK2tYrOChhJYMo/gs2TFNHW1Iwl4bAI/9sXZk+AT7oDI4Djlrflz4C2SaKC/TKSlxcy2NeBHUnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=QyQLpEKr; arc=none smtp.client-ip=203.205.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712027041; bh=f0et3YLWSIePPcZIcoiqWbK+lJdybPne5X9dc1FSB0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QyQLpEKr6ymwRVlMtzQpTnoVWszxP2UGL8XImHDRBdYlKoHquzhUaVPrGZSAmble0
	 858pW1e/IpodSGG/BJZkhBoNefZG4/0WBAsAjs3W2e6EtpfOGgQN7scHiSarmne0xk
	 C9hDGSvKKMnxSMrQpf6h3q4nfpi9Rx/bVrmgNspU=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id F7B1269; Tue, 02 Apr 2024 11:03:55 +0800
X-QQ-mid: xmsmtpt1712027035tl6wuhvyq
Message-ID: <tencent_A4FA0DA89270DDAC5D8519424F9B0DB42507@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMma0UugHJ1pNSaRgr38sPKTxRp/haZJnVNm9vIP2MTy5qQXnT4Kl9
	 Bxylf2jnjlHZxRuO4spSyJJIUAI32a27hDt1d12XptYYjh1r6yN2WDBtL7lQSvX+gSUF7U5cox2T
	 +ibjx3jonjUBt3JcJdgPAaRnQfkAuOqi0eeFn0k5VlTFtL/EEK1oaVaX3RtmGSPsjZlVexjSK8De
	 4izbwYC4MBlVSFbUPsM1bjhBAHc5m5gBEakGMAFsZg0BFyf/xFGU6qFC8wFSthQ9lT6M7SErPm/A
	 wZSNxQcTZM7yfqTosE94CgurG8ytN+iK9ADwpA4ouI9K6QSIevWDM6li4+16RAhpvKkM0ZSk4av5
	 KVOWXksJniY4I+dnwtXuFajY7DJPZUPHpVCSIHRvGHvW5Clzjclnr3xVxH7ghJ34H/sJbx21TsWi
	 qgBi7aCFftJ4EYYtyx+y6e0IeL702qI8yg/9IjLJP3GIVHj5hfb4O0LteEYLC3xtZpLaXyo4CQA4
	 vh5bQ0kyvE/aWGiRvo92frVbIS6h4oSGo+pgnWWQdKeofgy3tRE7q60m0AGUb6GFwweCgrvUac8P
	 w+liVGrPL2N6MK5kvkH0VXCvRVLhohNz/UYcwKqq1l5D81Hk+yxKchYp7wQPiLoI+aErZd3ONKsF
	 qNv7r8ikBRwFAgeVrvr5/4dGSkg4Rt0y4xqu1Ay8UbwO3tDHeetiz85P/95xa0v5vLkWV5BKPhwn
	 eGw2G1OpudxOYDmiC9izvt2xYuMzJY0xdVhTwRkSfPYXZ1pZxDqyvjKtxNwXovT2PbrM8qkXphcB
	 MxiAh3hCOUL+3j0xqbAnK+/T2r2hJtvHy8lHOUt1EllGvA70CXrJnNPmA6as09hxmIz90a74Qn7i
	 Xj1MT0Ket2oUtBzYkIIluzIPwRCZNTcgdMGzkhnQs3fhrAoib/MMDTLPCwJtnDEDPYHuRFPfyO9+
	 /47o85sHyL/nORIBe654uxACky1r5p
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: hawk@kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eadavis@qq.com,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	sdf@google.com,
	song@kernel.org,
	syzbot+af9492708df9797198d6@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH] bpf: fix null ptr deref in dev_map_enqueue
Date: Tue,  2 Apr 2024 11:03:56 +0800
X-OQ-MSGID: <20240402030355.1789902-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f45ad3e1-4433-422e-be28-17deaba4ade1@kernel.org>
References: <f45ad3e1-4433-422e-be28-17deaba4ade1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 1 Apr 2024 13:00:12 +0200, Jesper Dangaard Brouer wrote:
> > [Fix]
> > On the execution path of bpf_prog_test_run(), due to ri->map being NULL,
> > ri->tgtvalue was not set correctly.
> >
> > Reported-and-tested-by: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >   kernel/bpf/devmap.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> > index 4e2cdbb5629f..ef20de14154a 100644
> > --- a/kernel/bpf/devmap.c
> > +++ b/kernel/bpf/devmap.c
> > @@ -86,6 +86,7 @@ struct bpf_dtab {
> >   static DEFINE_PER_CPU(struct list_head, dev_flush_list);
> >   static DEFINE_SPINLOCK(dev_map_lock);
> >   static LIST_HEAD(dev_map_list);
> > +static bool is_valid_dst(struct bpf_dtab_netdev *obj, struct xdp_frame *xdpf);
> >
> >   static struct hlist_head *dev_map_create_hash(unsigned int entries,
> >   					      int numa_node)
> > @@ -536,7 +537,10 @@ int dev_xdp_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
> >   int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_frame *xdpf,
> >   		    struct net_device *dev_rx)
> >   {
> > -	struct net_device *dev = dst->dev;
> > +	struct net_device *dev;
> > +	if (!is_valid_dst(dst, xdpf))
> 
> This is overkill, because __xdp_enqueue() already contains most of the
> checks in is_valid_dst().
> 
> Why not:
> 
>   if (!dst)
> 	return -EINVAL;
This can work, but I think is_valid_dst() is better, as its internal inspection
of dst is more thorough.
> 
> 
> > +		return -EINVAL;
> > +	dev = dst->dev;
> >
> >   	return __xdp_enqueue(dev, xdpf, dev_rx, dst->xdp_prog);
> >   }
> 
> 
> Is this fix pampering over another issue?
> 
> To repeat myself:
> I think something is wrong in xdp_test_run_batch().
> The `ri->tgt_value` is being set in __bpf_xdp_redirect_map(), but I
> cannot see __bpf_xdp_redirect_map() being used in xdp_test_run_batch().
As I mentioned earlier, because the value of "ri->map" is NULL, even if it can 
be executed to __bpf_xdp_redirect_map(), it is meaningless because "ri->map" is
used internally to set "ri->tgt_value".
> 
> Is this a case of XDP program returning XDP_REDIRECT without having
> called the BPF helper for redirect?

Edward


