Return-Path: <linux-kernel+bounces-104782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A72087D385
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD911F22C40
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F2E4F1FE;
	Fri, 15 Mar 2024 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="16rpIxED"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439CE4C637;
	Fri, 15 Mar 2024 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710527108; cv=none; b=HcpmvqUNkfdNBW7QcRUUJQOP3KbPhbyMcbHKIQvXz0jgrJ2R0SfOo85RGpl962IAyMazBDUN+tLceieh26zdHJ7nwWrDQwa89cC/fPHipPvnEhf/FE/xhX4CvlwS/lDDUd98uNgtlhsbhrsk13qazn5zS9aoxsqjZxBYgTLOvEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710527108; c=relaxed/simple;
	bh=2Au1D4Ot5E6gkicxx9t/mBxMS77Y4uefkAMGQCX6YtM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=J9RsUqPt6bLIWL0Goa4uxuLLE4u7DY6hV90hUM8W4K2OjxS7FWRwqCQND4/WyrYxo+wDwm3nKCYRkK4W8yQpT89NLoe8Cbzhk1IoVhnEWYJktUCtETSqxdazl68NCNaOEtLWPIadyjjgzJYGpTjU6LjZTXcSLlkzLiQf5UDhrRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=16rpIxED; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710527103;
	bh=2Au1D4Ot5E6gkicxx9t/mBxMS77Y4uefkAMGQCX6YtM=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=16rpIxEDl1lS7NryEFGRRGGYJquuVBhgV60Gq9KFdxp1YvlU4VL1pgZLuNLoIc92E
	 xdfq4tB+lgEpzKXdVJ1r7XqfC89M2oVoxQ4rlIL3Cg1sqFc4+GJragentwQrSyNrTI
	 705D/2FfIcD4d+1SYdd3igNGEgiVWiWb/JognT34KrksMtbAfQow4qpGHPVxWANNeh
	 6AtRGvJOb0EvowdNZrG5FwpGJwyYhD8vClsr5nt8mKVaM2I2pe/7KrT1RWRsN3vHsx
	 Yw/clNLSuIHhCmvTKPhUJe+P1idU8fXvQHdtkX7YMqhT+tZ/o7kzUpJJVB7AC1gQhZ
	 xTupvx5lsj3kg==
Received: from smtpclient.apple (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 31D0637820D8;
	Fri, 15 Mar 2024 18:24:57 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v2,0/4] media: mediatek: vcodec: fix ctrl request complete
 fail
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20240314114452.17532-1-yunfei.dong@mediatek.com>
Date: Fri, 15 Mar 2024 15:24:44 -0300
Cc: =?utf-8?B?Ik7DrWNvbGFzIEYgLiBSIC4gQSAuIFByYWRvIg==?= <nfraprado@collabora.com>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Nathan Hebert <nhebert@chromium.org>,
 Sebastian Fricke <sebastian.fricke@collabora.com>,
 Hsin-Yi Wang <hsinyi@chromium.org>,
 Fritz Koenig <frkoenig@chromium.org>,
 Daniel Vetter <daniel@ffwll.ch>,
 Steve Cho <stevecho@chromium.org>,
 linux-media@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4DFF7ED9-CD67-415E-965D-D83337CBE8A7@collabora.com>
References: <20240314114452.17532-1-yunfei.dong@mediatek.com>
To: Yunfei Dong <yunfei.dong@mediatek.com>
X-Mailer: Apple Mail (2.3774.400.31)

Hi Yunfei!

I say this very respectfully, but I believe that you must improve the =
wording of some of your commit messages. It is hard to understand your =
changes otherwise. More importantly, it is hard to understand why they =
are needed or what exactly they fix.

This series has some checkpatch errors:=20

total: 53 errors, 0 warnings, 0 checks, 1047 lines checked

Did you test this with Fluster? We should really make sure that this =
does not regress any of the tests there.

See a few comments from me in the thread

=E2=80=94 Daniel

> On 14 Mar 2024, at 08:44, Yunfei Dong <yunfei.dong@mediatek.com> =
wrote:
>=20
> Moving v4l2_ctrl_request_complete to before of function
> v4l2_m2m_buf_done to make sure the status of request correctly.
>=20
> Replace v4l2_m2m_next_src_buf with v4l2_m2m_src_buf_remove to
> make sure the src buffer won't be removed for some unknown
> reason leading to buffer done error.
>=20
> Patch 1 setting request complete before buffer done
> Patch 3 flush decoder before remove all source buffer
> Patch 2 change flush decode from capture to output when stream off
> Patch 4 replace v4l2_m2m_next_src_buf with v4l2_m2m_src_buf_remove
> ---
> compared with v1:
> - add patch 2/3/4 to fix timing issue.
> ---
> Yunfei Dong (4):
>  media: mediatek: vcodec: setting request complete before buffer done
>  media: mediatek: vcodec: change flush decode from capture to output
>    when stream off
>  media: mediatek: vcodec: flush decoder before remove all source =
buffer
>  media: mediatek: vcodec: replace v4l2_m2m_next_src_buf with
>    v4l2_m2m_src_buf_remove
>=20
> .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  | 52 +++++++++----------
> .../vcodec/decoder/mtk_vcodec_dec_drv.h       |  3 +-
> .../vcodec/decoder/mtk_vcodec_dec_stateless.c | 28 +++++++---
> .../vcodec/decoder/vdec/vdec_av1_req_lat_if.c | 28 +++++-----
> .../decoder/vdec/vdec_h264_req_multi_if.c     |  3 +-
> .../decoder/vdec/vdec_hevc_req_multi_if.c     |  3 +-
> .../vcodec/decoder/vdec/vdec_vp9_req_lat_if.c | 37 ++++++-------
> .../mediatek/vcodec/decoder/vdec_msg_queue.h  |  2 +
> 8 files changed, 84 insertions(+), 72 deletions(-)
>=20
> --=20
> 2.18.0
>=20
>=20


