Return-Path: <linux-kernel+bounces-133481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB74D89A45A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81BC11F23249
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C54B172799;
	Fri,  5 Apr 2024 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ac1syLc6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C515172793;
	Fri,  5 Apr 2024 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712342536; cv=none; b=jEnTOvX6AOpacSlZh8L4vWIw/IGvH01buC04cZljS8/rpTAK56DWtaDLRnlYVUcBX7yExiQdS2GXuuSCbvVlSpt6PCzU/jcwXlFDGcjSJdgEKSDwQE372h8IlkwQwqbUkxSee0nUSa9OTN/MJ4nuzaOHugEGIgs2VEWUE/QzKcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712342536; c=relaxed/simple;
	bh=Ak6v9rbGghmGpiFluFVzlaA5Oh6/1f4GbxQrsFllnAM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=k7f5PWE7vOvXL4QDmJhAlSsyrU4FaBBYI9Zc6LZHD8UGvNXP8Qhf1dcIyVFPJV5GtBdP0Lpw73hKzGnLUfZQTSwhMXt87q+qg6CmVuoosRT37i5GFsfTTKI4W9LrjRIljhYCXX2UfP+m2K/J5YXVTmlDm2MTQ45E8fNL7qhzRPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ac1syLc6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF06C43390;
	Fri,  5 Apr 2024 18:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712342536;
	bh=Ak6v9rbGghmGpiFluFVzlaA5Oh6/1f4GbxQrsFllnAM=;
	h=From:Date:Subject:To:Cc:From;
	b=Ac1syLc6m50kY4Mj4USrXx5wXtTyNkAGbzOS8/vpbe53ZyYJJpKMUkRBuwp++P6Us
	 t6cIFlU1LV4y099Mzmqb2UnZygO1NlZL12gytrEPYaPv546DOK6PsreNz1ybFNjPg6
	 TowI8u3fC6eAiI4OMCdeKTAGPnOTDmy3FKiqrlPR131qWC/JDApVjDRXAbLaPBc2ph
	 5IA+vVb2r1oiS4zLlQru44RgJPUE7hJJr+7ISuMmz14SdkZAgOVM5NzY2AXT+Fe+/y
	 P6Wo/7r6BzYaWt4rHXpNlX2PdZPpNRhGF+OkzNz/l/IacgkiVf8z3rUnEPDEHw1Gcm
	 OQ+HuSCBVhwsA==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a9ef9ba998so374838eaf.1;
        Fri, 05 Apr 2024 11:42:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJirOL2bdlyR+Pzes/Mm1HWiG+WuTTsVnK2a2js1Zz1ADXxrX1sl1NrJFtEgeGnNH+6USDIbQ7inlE4pxv/bi2UGzlwrSZ9Ida/sSa
X-Gm-Message-State: AOJu0YyeGqXr3Y1iqY0HhebG7TJQP99y+hC7yPb327fzwVdbpzVW6Y/m
	PAT0I6twaSmc4mSE+HE1rLdOxxO+TPDU6C1Q7+eXmTIZMpoYQrItmVbtrPmyxx59cjNyTzOGM0r
	neKfewDNqzVbuW+oSQ52wKHgrSDs=
X-Google-Smtp-Source: AGHT+IHa4Y2pb37I/713DfZdVtE/UlHCMq7EzxKt8VxfzdWAjIbu4L/Z77dvQVqjyo17HZMlPQtC3iHlNwnlCHkWmzA=
X-Received: by 2002:a05:6820:2b81:b0:5a6:2c6b:d3b with SMTP id
 du1-20020a0568202b8100b005a62c6b0d3bmr2690755oob.0.1712342535472; Fri, 05 Apr
 2024 11:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Apr 2024 20:42:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gVqOUuFfJ8um+_F_ubU4QsWYneyQsFBHu9rG10-rJYEg@mail.gmail.com>
Message-ID: <CAJZ5v0gVqOUuFfJ8um+_F_ubU4QsWYneyQsFBHu9rG10-rJYEg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.9-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.9-rc3

with top-most commit 8130b05c559d1aa83d0c8971b422ba0da18ef24a

 PM: EM: fix wrong utilization estimation in em_cpu_energy()

on top of commit 39cd87c4eb2b893354f3b850f916353f2658ae6f

 Linux 6.9-rc2

to receive a power management fix for 6.9-rc3.

This fixes a recent Energy Model change that went against a recent
scheduler change made independently (Vincent Guittot).

Thanks!


---------------

Vincent Guittot (1):
      PM: EM: fix wrong utilization estimation in em_cpu_energy()

---------------

 include/linux/energy_model.h | 1 -
 1 file changed, 1 deletion(-)

