Return-Path: <linux-kernel+bounces-86740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE76C86CA0C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C25E1C20D3A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852757E561;
	Thu, 29 Feb 2024 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PXvXJg7K";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PXvXJg7K"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE491DFE3;
	Thu, 29 Feb 2024 13:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709212738; cv=none; b=ZPh/au95ySRA/tG60x02T3R9caSSL+w5LeC7L5uNtq19v8ZsgO73lVYnvCAnynJ0ICzYH+6OnmICqHJGjUitAiw4BCC9qHcSy1KnchNuM3oQjOrgILi00Q+F3iBbOib2AcvhlEZRRJIh4D1Jxvll7UJxvfy3b+R8//AJGL59dno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709212738; c=relaxed/simple;
	bh=e9ApuH6Hz9Lx3CwIlv2WZ1oQLTe/qwHB9BrcYoFh5lU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=n4sWmzDXgX64FBhhOYaXE5RqtKJWGMeO7L5Bv7fyR+B1leu/vkc3Tn+hdQ90Eh900Ytw1gK1PM69LDs+eKbLeoBiOe6Q6SEkKuTZkIWM8bobkU6aJOXywJ206dnxv6NBCo6bC/DYr5zYm71xL+nHxqROQG6ZT7aOGiJqIWAl3N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PXvXJg7K; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PXvXJg7K; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4048A1F7E6;
	Thu, 29 Feb 2024 13:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709212735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=e9ApuH6Hz9Lx3CwIlv2WZ1oQLTe/qwHB9BrcYoFh5lU=;
	b=PXvXJg7KNFMqAEEbUgR3dKFbpUJrNGGevJnF1jzbveRf9boYcey0ULOT/I9YdJjh6TfPO9
	BJkxFc/9rEVNjf4D7v6vNoVD7Tr5C7Ek6WBScgkXSEQnvcEjgrPs6YesERaL7YqRMMd2YK
	tfddMu1PZTf37fYnlH1qr/wWWH4T7mg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709212735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=e9ApuH6Hz9Lx3CwIlv2WZ1oQLTe/qwHB9BrcYoFh5lU=;
	b=PXvXJg7KNFMqAEEbUgR3dKFbpUJrNGGevJnF1jzbveRf9boYcey0ULOT/I9YdJjh6TfPO9
	BJkxFc/9rEVNjf4D7v6vNoVD7Tr5C7Ek6WBScgkXSEQnvcEjgrPs6YesERaL7YqRMMd2YK
	tfddMu1PZTf37fYnlH1qr/wWWH4T7mg=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F064A13451;
	Thu, 29 Feb 2024 13:18:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id XsU0OD6E4GWPKQAAn2gu4w
	(envelope-from <oneukum@suse.com>); Thu, 29 Feb 2024 13:18:54 +0000
From: Oliver Neukum <oneukum@suse.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: 
Date: Thu, 29 Feb 2024 14:17:32 +0100
Message-ID: <20240229131851.16148-1-oneukum@suse.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: **
X-Spamd-Bar: ++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=PXvXJg7K
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [2.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 EMPTY_SUBJECT(1.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[13.07%]
X-Spam-Score: 2.49
X-Rspamd-Queue-Id: 4048A1F7E6
X-Spam-Flag: NO

This is intended to be a cleanup

