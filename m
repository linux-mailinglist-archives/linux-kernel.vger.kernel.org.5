Return-Path: <linux-kernel+bounces-117635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 164FB88B1B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FF71B43B12
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B671FA6;
	Mon, 25 Mar 2024 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJnQoHs8"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C455812E55
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388868; cv=none; b=SlMqhINzFEY4e9DRuWRfSa+fLKwIrzxXgXw0lnW38ia/OJxEl7CTzrq+taOZV7IdmqYmVMOn8ssGZ/D7FsSbUE0lt+PpmW0opYdxdxtjxw4obJynapdqiAVCxTrF3yEhsd7s6xaFFUK+qXzCLg5yIvdibAGrzzZ+Jd2lJSz9XTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388868; c=relaxed/simple;
	bh=x79bQNpuZSSP4gO8yikz0VUCiVgrNxK4tK/sdFtNq40=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=npbxLBu5dGonfjXqfa0V/C960SGzI/n0duRHJUoCJGK/xnXcQcBgELGFEpn/UD3q9o4joZJgIYykQOdU0gVA+Ui2ikkO0g9mMIyzmkJxu7HFFm46emjg6w5gsOyZeehdCPUNsZc9A7iITZzlCPr3KAhBdCY+DyxL1l4W4BLUo58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJnQoHs8; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e74bd85f26so3629585b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711388866; x=1711993666; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mEPz6M5iHmHoPmbFs3iYprvWP2TggHiaslNWFi8OZW0=;
        b=BJnQoHs8bpL4zamgmjEna2s/I1WNMpOfx6EIolcIXzx4vXAYCMGiJ2QLDN9uWq0GHO
         XKcerwRCKRjcxcvHG0dNHy89FpYQeEEGVRNAqBOrzzF+oeunJZho6tAa4FNmuUiJaVGv
         W2bh+f5Jmtn4k3IPByLVU9L3a5Et5vOX2yusffJy4H2gCMusYcF8p8Vdm5fSTybzrMgE
         DNo32OnCVxWswgOAEnYvM+0jgSHO6MqXMtNpTrLQyx4rwgWFuMMZtfBHt7m46EIavYh5
         3aLh1pYwSVU1oPCewqxL2UJMk0O2P6rz1E0/OdwFSmZvz0fCRvK1+0W8avbbJXJHu6gQ
         6xmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711388866; x=1711993666;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mEPz6M5iHmHoPmbFs3iYprvWP2TggHiaslNWFi8OZW0=;
        b=pZfx+eCT9R+3RK3wFDtyjPV+cJH7va3HkIyy5M95T4E2ZJMAmgNT9eH7OlRezWB7Y5
         qSDNdc3z0AFaf9a+ayC2ANUppui6XObsglN4vt7CAzfQeJnJzKtgUVfXfKHvr3lkDimc
         5yJNzTb2OmLw2XvRbOvFqIbH3azNsjWvlhLJ9HwRhPJbDxPdaRqLt1lAnJYmE0rwiQy+
         O1Tfsb3kwa5GaoudAhb32KlDQ+qLNF98OaRXoEUAQe/E91vBqY9/lbRdinTIVnuhLHME
         plRAwq/HRjBbdWn7PDnNlb25n8TW8s40ErzchKr8pI66CguT0ARJUTGDR8l9D8poGKJy
         tb6g==
X-Forwarded-Encrypted: i=1; AJvYcCV/Dciqj49yKgfsn28ciFsgoYPyM4xTjxs4Aq29Qp5LvY/lcUPphoaHJnFUiifMy8YiVlRGD021Fpzy3Pt/UgilFG8c4Wzi4uPM2wP0
X-Gm-Message-State: AOJu0YwQMS54LE2PAoI1EFAbTkxcwjwy7f8GMvyxtcKYk98b2vKScKEB
	3qoZVUukgu0yBltV1e9fhhgVPbKm8Ut7tVCffTSBQJ94FmPPea7f
X-Google-Smtp-Source: AGHT+IFGLoJ906tIgvVPhFldOKi+aRwpKUD3HGt3rUE/+t7NYeCllhEhK3pUP1gIHVT2SA4qZU2rjQ==
X-Received: by 2002:a05:6a21:182:b0:1a3:b034:ca42 with SMTP id le2-20020a056a21018200b001a3b034ca42mr8109908pzb.40.1711388865962;
        Mon, 25 Mar 2024 10:47:45 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.65])
        by smtp.gmail.com with ESMTPSA id k6-20020aa79986000000b006e6b415b405sm4322581pfh.36.2024.03.25.10.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:47:45 -0700 (PDT)
Date: Mon, 25 Mar 2024 23:17:40 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v4 0/3] staging: rtl8712: Trivial code cleanup patches
Message-ID: <cover.1711388443.git.ayushtiw0110@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Address different kinds of checkpatch complains for the rtl8712 module
to ensure adherence to coding style guidelines.

v4: Update the changelog to match revision history
v3: Update memcpy() param to match new name backup_PMKID_list
v2: No changes. Just a patch sending error.

Ayush Tiwari (3):
  staging: rtl8712: rename backupPMKIDList to backup_PMKID_list
  staging: rtl8712: rename backupPMKIDIndex to backup_PMKID_index
  staging: rtl8712: rename backupTKIPCountermeasure to
    backup_TKIP_countermeasure

 drivers/staging/rtl8712/mlme_linux.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.40.1


