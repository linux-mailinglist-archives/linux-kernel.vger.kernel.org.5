Return-Path: <linux-kernel+bounces-14959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF25B822507
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDAC61C21FA0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32E717731;
	Tue,  2 Jan 2024 22:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=willian.wang header.i=@willian.wang header.b="pqnGDHqT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-200161.simplelogin.co (mail-200161.simplelogin.co [176.119.200.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B9D1775B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willian.wang
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willian.wang
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1704236204;
	cv=none; b=Z9/h2+zXcOQMI55WEwKuMp8u5z+JH/r/wFuryOXSUgBlz9shtRJG7gkpWI7yXhM+Owe2vS+nzUewdXnM0OfIX0bI5LrcQxoHs/js7amj7yt1/DRfKfDp6uSfpARDFHf51L7Bp+gwO0Pj7kCAnUtGM5G9fEAcjKFY/+5T03R77CbWOB8O7UJ006Yt1yzbh/yZqitwwTMNys+7vgGy9w9ycZHed8ngGOl0VCMr+GiI6vt8EG92YO37uFi9boao6g8sqY5sKxQmMkTAvt9smyVJjdsphuX5xfRKV9i4UkAfNSL94oBni+9NxUtH2Dv8CRfAr60++0TOChLv31HBwee8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1704236204; c=relaxed/simple;
	bh=kWAKk3nloB2r8KYY+fac/aEI7U47DszvlPld13tJ92g=;
	h=DKIM-Signature:MIME-Version:Date:Subject:Content-Type:
	 Content-Transfer-Encoding:From:To:Cc:Message-ID:X-SimpleLogin-Type:
	 X-SimpleLogin-EmailLog-ID:X-SimpleLogin-Want-Signing; b=MANzUFNr/lf9+8YoUMGP94yjw7AmUI+mCHLManqDc84o8/kqUH0FP21rE60X/hOF1EQ26vKFTSNlyK88PwFLaJpgYADocGkMFEfjEthStU5DtJc4rhZYiBzAwNOyNX86d2dUh3IOLkLmuL/7KhYE9/3/GjmU9YvEapRNOx2gnJ8pktDHGCwT0PdjOaWF/jjDXzRXT7Fmr6i/qxOe9hU74zoq+qlBQ5ZwyF3sPzjA4TAowukkqKn91cMS0Ddf8YlR7WcuchHr+uILqEFadTDGuqRFBj6QFDEoYN4zr/fQvgUmen6z/c3g7UvX8czsaz+By9ws85IWRiYiF4LatlGuEQ==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willian.wang;
	s=dkim; t=1704236203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kWAKk3nloB2r8KYY+fac/aEI7U47DszvlPld13tJ92g=;
	b=pqnGDHqTjQs5BE0srLfFcVv8xeukUD5pbZkKHssd34hO8U2aGvplRQQxeHlSCo1ZkVZ2O+
	Z9laKVfdMRk8sE2JIVKA676z8r2mRdp07fIu9WKNQRWWU2d+iM+2t2LMWWYHA+UUi+cS7T
	7uz/DAmgKMZzmt68J1xT03Hd/yBfZGs=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 2 Jan 2024 19:56:03 -0300
Subject: Re: Oops in hdac_hda_dev_probe (6.7-rc7)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
From: Willian Wang <kernel@willian.wang>
To: peter.ujfalusi@linux.intel.com
Cc: 
 tiwai@suse.com,regressions@lists.linux.dev,tiwai@suse.de,ranjani.sridharan@linux.intel.com,pierre-louis.bossart@linux.intel.com,perex@perex.cz,linux-sound@vger.kernel.org,linux-kernel@vger.kernel.org,kai.vehmanen@linux.intel.com,lgirdwood@gmail.com,broonie@kernel.org,alsa-devel@alsa-project.org,linux@dominikbrodowski.net
Message-ID: <170423620368.7.11626876748388238508.241693435@willian.wang>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 241693435
X-SimpleLogin-Want-Signing: yes

Hi, just tested the patch and both sound and resume-from-suspend are
working like 6.6 again =F0=9F=91=8D


