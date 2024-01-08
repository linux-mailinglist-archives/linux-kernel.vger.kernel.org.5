Return-Path: <linux-kernel+bounces-19915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA0682769E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53AF2847A4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0063B54F87;
	Mon,  8 Jan 2024 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="QwhRj2Ft"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B176E54BF9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3f29fea66so6844875ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 09:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704736032; x=1705340832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1iaOEh5y9aboYMTed+aamtV3KcDRPhqHF35NpDISIS0=;
        b=QwhRj2FtTyioiB1KEXatn+TvdZa5OdnVSgILC/GV6O6ieHulE4efs4QdP4WlSquEo1
         T8sM33G45ft5l90pIIJZu7u+ItJAsS2qQwe0BhvqyPK5EeOYFZO44PHMZCgziSwCPjT4
         gfvyvrohLX9JOnlQYfRU5dxXHO1JdLfx+cFvFCX64M/rqtckXPv2QpQzZ10/YFCzMwUB
         XhZS44pby0dLe5ZG+m1R8z+ISn8ut8WYiTvO3XdHnnElYCbd3AsfGqsaSGxCY+gB2N06
         a9yNGPJFjI8Xvh3ScckoimvfmEcBKBr71NNyyEJPHsGf0+rpq7lIrT7joy1fdbWx+y6b
         JTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704736032; x=1705340832;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1iaOEh5y9aboYMTed+aamtV3KcDRPhqHF35NpDISIS0=;
        b=HT++TXvQvlPsLyb6RuY475N7OHs89FQtNpWVXC+mHI66TgqtBAxGz8WKJ2WOH3t3MJ
         oAwe4oQOtzDrJvImFIMmlLAVJMLqI/1Zdq5hYtLXIbm3H53GND+HmMp3+1rZVUoWAW/V
         z/bkXatd4PiVPIV2CQyw4+9WKa1JHqqHbfb/3GHSg8NTg5GXC3MXSgZAN2o6hnD9Lq1n
         JEY1Z4JfLogjiDAi/JKaY75Er60trWI8yimfreDESV8Fs+NZCIFixkAlpebyTGz/V6x4
         SdXC4bWPWq0EB464NGE7HqhSERF7knOJy57ZjtDCsIpN9MsaSFnDYNYHPGjsNM6x+XGm
         39jQ==
X-Gm-Message-State: AOJu0YxC0DofNTxhGVHj5Zva1MTdUH+v/2pEdO/ofwH0MmS9bsYuSfcV
	xxHfKcz5PYIoUy9XVM1eoT28k7W+1jvLny9MCTMJcmZPqCY=
X-Google-Smtp-Source: AGHT+IG61JCOZrmpJ1uodRk8qF6BcpsWMuZHiBcuhs9pOCsji5mzvHM2db38ZsAl9rOPEC6IUcRT9w==
X-Received: by 2002:a17:903:454:b0:1d4:3314:d3cb with SMTP id iw20-20020a170903045400b001d43314d3cbmr1367221plb.119.1704736031963;
        Mon, 08 Jan 2024 09:47:11 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id ay8-20020a1709028b8800b001d49f61cb64sm161008plb.262.2024.01.08.09.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 09:47:11 -0800 (PST)
Date: Mon, 8 Jan 2024 09:47:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] iproute2 6.7.0 release
Message-ID: <20240108094709.050e22bc@hermes.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Update release of iproute2 corresponding to the 6.7 kernel.
Most of the changes in this release are in bridge and rdma tools.

Download:
    https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.7.0.tar.gz

Repository for current release
    https://github.com/shemminger/iproute2.git
    git://git.kernel.org/pub/scm/network/iproute2/iproute2.git

And future release (net-next):
    git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git

Contributions:

Allen Hubbe (1):
      vdpa: consume device_features parameter

Amit Cohen (8):
      bridge: fdb: rename some variables to contain 'brport'
      bridge: fdb: support match on source VNI in flush command
      bridge: fdb: support match on nexthop ID in flush command
      bridge: fdb: support match on destination VNI in flush command
      bridge: fdb: support match on destination port in flush command
      bridge: fdb: support match on destination IP in flush command
      bridge: fdb: support match on [no]router flag in flush command
      man: bridge: add a note about using 'master' and 'self' with flush

Andrea Claudi (3):
      configure: add the --color option
      treewide: use configured value as the default color output
      Makefile: use /usr/share/iproute2 for config files

Benjamin Poirier (18):
      bridge: vni: Accept 'del' command
      bridge: vni: Remove dead code in group argument parsing
      bridge: vni: Fix duplicate group and remote error messages
      bridge: vni: Report duplicate vni argument using duparg()
      bridge: vni: Fix vni filter help strings
      bridge: vlan: Use printf() to avoid temporary buffer
      bridge: vlan: Remove paranoid check
      bridge: vni: Remove print_vnifilter_rtm_filter()
      bridge: vni: Move open_json_object() within print_vni()
      bridge: vni: Guard close_vni_port() call
      bridge: vni: Reverse the logic in print_vnifilter_rtm()
      bridge: vni: Remove stray newlines after each interface
      bridge: vni: Replace open-coded instance of print_nl()
      bridge: vni: Remove unused argument in open_vni_port()
      bridge: vni: Align output columns
      bridge: vni: Indent statistics with 2 spaces
      bridge: Deduplicate print_range()
      bridge: Provide rta_type()

David Ahern (2):
      Update kernel headers
      Update kernel headers

Dima Chumak (2):
      devlink: Support setting port function ipsec_crypto cap
      devlink: Support setting port function ipsec_packet cap

Eli Schwartz (1):
      configure: avoid un-recommended command substitution form

Ido Schimmel (1):
      bridge: mdb: Add get support

Jiri Pirko (1):
      mnl_utils: sanitize incoming netlink payload size in callbacks

Johannes Nixdorf (1):
      iplink: bridge: Add support for bridge FDB learning limits

Junxian Huang (1):
      rdma: Update uapi headers

Luca Boccassi (1):
      Revert "Makefile: ensure CONF_USR_DIR honours the libdir config"

Maks Mishin (1):
      lnstat: Fix deref of null in print_json() function

Max Kunzelmann (1):
      libnetlink: validate nlmsg header length first

Patrisious Haddad (3):
      rdma: update uapi headers
      rdma: Add an option to set privileged QKEY parameter
      rdma: Adjust man page for rdma system set privileged-qkey command

Phil Sutter (2):
      man: ip-route.8: Fix typo in rt_protos location spec
      man: Fix malformatted database file locations

Quentin Deslandes (1):
      ss: prevent "Process" column from being printed unless requested

Shung-Hsi Yu (2):
      libbpf: set kernel_log_level when available
      bpf: increase verifier verbosity when in verbose mode

Stephen Hemminger (18):
      uapi: update headers from 6.7-rc1
      ip: move get_failed blocks
      man: fix man page errors
      man: allow up to 100 character lines
      iplink: spelling fix in error message
      ip: require RTM_NEWLINK
      uapi: update stddef.h
      configure: drop test for ATM
      ip-link: use shorter URL to kernel docs
      rdma: use print_XXX instead of COLOR_NONE
      ip: merge duplicate if clauses
      rdma: shorten print_ lines
      rdma: use standard flag for json
      rdma: make pretty behave like other commands
      rdma: make supress_errors a bit
      rdma: add oneline flag
      rdma: do not mix newline and json object
      v6.7.0

heminhong (2):
      iproute2: prevent memory leak
      iproute2: prevent memory leak on error return

wenglianfa (2):
      rdma: Add support to dump SRQ resource in raw format
      rdma: Fix the error of accessing string variable outside the lifecycle


