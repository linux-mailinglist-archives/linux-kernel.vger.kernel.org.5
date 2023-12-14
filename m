Return-Path: <linux-kernel+bounces-223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9E4813E04
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4101C21E80
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F144E6DCF2;
	Thu, 14 Dec 2023 23:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="riEueaeT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BE966ACE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5b8d4a559ddso149221a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 15:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702595339; x=1703200139; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m1XHLYDgttvIMmrtDZCBn4GcSoDP8mjqcR9fU091Bms=;
        b=riEueaeTjJKOjhmJ5OYnP3E2dqgce9V1C4XXgWmAgNibnsHKjDwpwg8V1Zwn+k65+s
         /uOzu/PQSO4qWzLGmvG92QwjDZk4gb0zfYV6D7L0b0Sr3YuR0rtX2Q4JeysXgrCbuqXr
         gb86OV9oFnRs/VE/Ec5pTgDoU8OFX/MCG8w74KFmsxEdkVxRabSKXH5Jr0QY2CpiWn5a
         AzykBGM63Qd48QsZAB2rtlKfUXRgLE82YSIcGCrRlGhD/RifmOo1OEvXwUL7b68tJhD/
         ZC36TPzHrVrh5USfwTA6LJxj0y8HNQsLAeDrFzfJtz/P79Z6U5uCD6YMy645GeY9wlEg
         ZV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702595339; x=1703200139;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m1XHLYDgttvIMmrtDZCBn4GcSoDP8mjqcR9fU091Bms=;
        b=a0NxPhwrOx158L+LuvPlPoGLa5aronJqcts9ye8QzY8BTA8cd+WNGh0zxESUXsN/Lh
         Z85K2snCQogpYsDs86GUbWMUHUhik9jqGZsSXCrLYRWGiPvAhpQKYoU7Nl8rMcnod96U
         fhGzDH29NyUen3af4lipwjQrtjnb674zasIhM7z6XLzLx1U1fOAI+qUQYgXDmF15Zjt1
         fbb5KC2PkqdwuuPpzWLVyJeVYajY8Jh2NAGsK/gadrM1UK4U3XBIGY3zR3SjPu6zzzGQ
         DWSuArtOnptDJU6AbMeNF3DhdL/b/b6540/ZUD/CItnmC4eAMtdEijO1vVWWyq0pxek6
         QpOg==
X-Gm-Message-State: AOJu0Yy2mm8YTg7cM8SKc3fqyoVPZkAVgY16CxXP1nzIDAYmB8Nz05oU
	v+DiDUpvYa7III6Bx2J1Lf/aEX1M9CjtS5Y=
X-Google-Smtp-Source: AGHT+IHDJKWfSybkMhla9TdjhPbSbpqNJOcAfa+si8NqEKf1OW4EzAfPd636heZxGpEYkLGQUXaSbcDZZc+uHsA=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a63:7257:0:b0:5b9:63f2:e4cc with SMTP id
 c23-20020a637257000000b005b963f2e4ccmr751102pgn.2.1702595339152; Thu, 14 Dec
 2023 15:08:59 -0800 (PST)
Date: Thu, 14 Dec 2023 23:08:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3372; i=rdbabiera@google.com;
 h=from:subject; bh=IYcw+cHXq4wHuxatFe2diBHKZYJEbfEV7ubHbpP+JVo=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKnV3UxnM+6KZ9kb9fqERN51Nc9MV2m/u2S6VH2R2XbDW
 DOFi+0dpSwMYhwMsmKKLLr+eQY3rqRumcNZYwwzh5UJZAgDF6cATKTqB8M/7bvXvB8Ye37fyCb/
 if9Ty5v5KRbFrSlMK74qXi7kX1t1l5GhO71vsb9SWnbtZy7WqvpkY0aRg2dYH28yv/ht940VypX sAA==
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214230850.379863-14-rdbabiera@google.com>
Subject: [PATCH v2 00/12] usb: typec: add SOP' support to the tcpm and alt
 mode drivers
From: RD Babiera <rdbabiera@google.com>
To: rdbabiera@google.com, heikki.krogerus@linux.intel.com, linux@roeck-us.net, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Cc: badhri@google.com, bryan.odonoghue@linaro.org, agross@kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org
Content-Type: text/plain; charset="UTF-8"

Extend the TCPM's functionality to include support for SOP' messages.
This feature is opt-in: TCPCI chip drivers opt into sending and receiving
SOP' messages. TCPCI drivers will also be expected to take the SOP frame
type in order to process SOP' messages within the TCPM. Specifically,
the exisiting API tcpm_pd_receive now takes tcpm_transmit_type as input.
The Maxim TCPCI implements this in Patch 4.

Discover Identity, Discover SVIDs, Discover Modes, and Alt Mode SVDM
support are included within the patchset. Because the port is expected to
be the Vconn source in order to communicate with the cable, TCPCI chip
drivers opt into performing a Vconn swap after Discover Identity on SOP
before performing Discover Identity on SOP'.

typec_cable_ops are defined to facilitate communication between the alt
mode drivers and the cable plugs. 2 new apis allow the alt mode drivers
to enter and exit mode on active cable plugs. A third is used by alt mode
drivers to send VDMs to the cable plugs or by the TCPM to return the
resulting VDM from the cable plug to the alt mode drivers.
---
Changes since v1:
* Add typec_cable_ops as replacement for changing typec_altmode_ops
  interface. Displayport driver patch now reflects this
* Separate patch for cable SVDM versioning.
* Separate patch for tcpm_pd_receive() api changes and cable_comm_capable
  addition to tcpci.
* Separate patches for Discover SVIDs/Discover Modes and Alt Mode
  operations on SOP'.

RD Babiera (12):
  usb: typec: altmodes: add typec_cable_ops to typec_altmode
  usb: typec: altmodes: add svdm version info for typec cables
  usb: typec: tcpci: add cable_comm_capable attribute
  usb: typec: tcpci: add tcpm_transmit_type to tcpm_pd_receive
  usb: typec: tcpm: process receive and transmission of sop' messages
  usb: typec: tcpm: add control message support to sop'
  usb: typec: tcpci: add attempt_vconn_swap_discovery callback
  usb: typec: tcpm: add discover identity support for SOP'
  usb: typec: tcpm: add state machine support for
    SRC_VDM_IDENTITY_REQUEST
  usb: typec: tcpm: add discover svids and discover modes support for
    sop'
  usb: typec: tcpm: add alt mode enter/exit/vdm support for sop'
  usb: typec: altmodes/displayport: add SOP' support

 drivers/usb/typec/altmodes/displayport.c      |  161 ++-
 drivers/usb/typec/bus.c                       |  102 ++
 drivers/usb/typec/class.c                     |   59 +
 drivers/usb/typec/class.h                     |    1 +
 drivers/usb/typec/tcpm/fusb302.c              |    2 +-
 .../typec/tcpm/qcom/qcom_pmic_typec_pdphy.c   |    2 +-
 drivers/usb/typec/tcpm/tcpci.c                |   26 +-
 drivers/usb/typec/tcpm/tcpci_maxim.h          |    1 +
 drivers/usb/typec/tcpm/tcpci_maxim_core.c     |   38 +-
 drivers/usb/typec/tcpm/tcpm.c                 | 1043 ++++++++++++++---
 drivers/usb/typec/tcpm/wcove.c                |    2 +-
 include/linux/usb/pd.h                        |    1 +
 include/linux/usb/pd_vdo.h                    |    8 +-
 include/linux/usb/tcpci.h                     |   13 +
 include/linux/usb/tcpm.h                      |   16 +-
 include/linux/usb/typec.h                     |    7 +
 include/linux/usb/typec_altmode.h             |   30 +
 17 files changed, 1346 insertions(+), 166 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog


