Return-Path: <linux-kernel+bounces-128305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBD0895919
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0571E1F227EF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CF41369A2;
	Tue,  2 Apr 2024 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="hvEGzKtS"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3325B136980;
	Tue,  2 Apr 2024 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073558; cv=none; b=KTI8TYEwSkEvLW7bZcKDeDepC174WeEl22ad2Z251nHm0BLAjt9ZBFjdpIw9o2Yv6i3LQw0TUOlVVwkLoi0uSgss3W4qDsiRK/A7MFAJBWLZFpk6LRoq6dsQEW+fSUT4bkvitiln4lQz+Gm8ueiJ5LjVL6YH/hTC2bUyPvieG20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073558; c=relaxed/simple;
	bh=4W2F+lnZAH2bD7lx3waSQduh4rTG8XhmWyZ/L37zFbA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jMITYY7nCAPecY152GnvjwMkXXQl7TZKRDGeV+m871c6tRqRdkS3NjrlJB3sI9ve2UTiZkaotd1ZWPvv6L0GJhJM7BxKLxXPmbDUX8W0kZwpKTLeFFPMsGx66NkibHYgDJxysI7VIKJS7SbFQJVia0+jD5dGFtFHynaEmIScPjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=hvEGzKtS; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6662F47C3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1712073556; bh=WMeJn3vidfAVMmh7rXTscLXdrF7bcV2psAQw7kcurJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hvEGzKtSRCPayMQw0WkJG4HMt32o7Nuw0V5i+VIU/z0VI5j9upByQDiEGMFuFGA57
	 qxmKWTlX0MhLFLQMCb3swSlQZZmOnLKzPryTWd8lrbMcD3UPZMYxaozbSmoKnCEtA1
	 0z9teSUBBXGq4x9MX+LscUSds8CmhkaXuZ7ZpDONSZVyXP0Fkryuxz2cuwNHKm8DEl
	 X6MuRL7CVya5ZVTbgH9mN9m4aboyVrcm4f6f/X1oDaRNQ6iAYY7eGgOw1ZlWUDkgxP
	 nk8LsXw8DeChL72+nZgAYVzmuifJbzHwbFJsUC63/I3QRxYCuG+aiCFSjdl41mDaDG
	 Cv2qb6C8+z1+Q==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6662F47C3C;
	Tue,  2 Apr 2024 15:59:16 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-doc@vger.kernel.org, carlos.bilbao@amd.com,
 linux-kernel@vger.kernel.org, avadnaik@amd.com
Subject: Re: [PATCH 0/4] Translate development-process into Spanish
In-Reply-To: <20240305221839.2764380-1-avadhut.naik@amd.com>
References: <20240305221839.2764380-1-avadhut.naik@amd.com>
Date: Tue, 02 Apr 2024 09:59:15 -0600
Message-ID: <874jcjwyb0.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Avadhut Naik <avadhut.naik@amd.com> writes:

> This patch set translates development-process and two of its associated
> files into Spanish.
>
> The first patch updates the Spanish version of process/submitting-patches
> with the changes recently introduced into its original English version.
>
> The second patch translates the process/development-process into
> Spanish.
>
> The third patch translates the process/1.Intro file into Spanish
>
> The fourth patch translates process/2.Process file into Spanish.
>
> NOTE:
> In order to avoid broken links in process/1.Intro, empty files have been
> created for the documents, associated with development-process, that have
> not been translated yet. Similar approach was taken for Italian
> translations some time back.
>
> Link: https://lore.kernel.org/lkml/20181108232417.14982-1-federico.vaga@vaga.pv.it/
>
> Translations for these documents will be submitted within the coming
> months.
>
> Avadhut Naik (4):
>   docs/sp_SP: Update process/submitting-patches
>   docs/sp_SP: Add translation of process/development-process.rst
>   docs/sp_SP: Add translation of process/1.Intro.rst
>   docs/sp_SP: Add translation of process/2.Process.rst
>
>  .../translations/sp_SP/process/1.Intro.rst    | 302 ++++++++++
>  .../translations/sp_SP/process/2.Process.rst  | 542 ++++++++++++++++++
>  .../sp_SP/process/3.Early-stage.rst           |  11 +
>  .../translations/sp_SP/process/4.Coding.rst   |  11 +
>  .../translations/sp_SP/process/5.Posting.rst  |  11 +
>  .../sp_SP/process/6.Followthrough.rst         |  11 +
>  .../sp_SP/process/7.AdvancedTopics.rst        |  11 +
>  .../sp_SP/process/8.Conclusion.rst            |  11 +
>  .../sp_SP/process/development-process.rst     |  27 +
>  .../translations/sp_SP/process/index.rst      |   1 +
>  .../sp_SP/process/submitting-patches.rst      |  28 +
>  11 files changed, 966 insertions(+)

Applied, thanks.

jon

