Return-Path: <linux-kernel+bounces-20017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF566827847
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638571F23C26
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E229454FB3;
	Mon,  8 Jan 2024 19:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HxR0w1Nu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A2554F91
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 19:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9ef2422cso1902239276.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 11:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704741390; x=1705346190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2bGe+uuOkBgrwm/2cptBzkQ5d6/QuIv5dqSJD9o8kNM=;
        b=HxR0w1NutpaRr0hdvjfOlazRtz3YbRVi++Nocw03BUulcUOHObHNGIAqrYLmw5aXSN
         QI1awL1PvOwuQK5PcljBr8EggVZByBv6bFLkCjt9klU7TsjVAeu3Ly3aH4tTdVvxeIib
         057uUI9Y0zkOqw1oZgq6sbI58G8+/0vGAaAeQsr+T50XLGgkjbK3G5ceWYUtaLt0n3vb
         ZmdjiZsfWXHY7qz8Il4AezJo5UF/Enpw7SKhUViOac6R8zmjv7WPiMpEQ42yIuYK8S4Q
         pzQfdz5HYaH+4Pzr9FdbqDnpCx9dtPWNZtkBK/mkR88FGR3kQ/902YiVangZJRATXe1B
         KJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704741390; x=1705346190;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2bGe+uuOkBgrwm/2cptBzkQ5d6/QuIv5dqSJD9o8kNM=;
        b=TPakXUYtHoGtt/gn8WtdcejOQrhOSLDtcjAMbgicRZa/4mriKLzl6Da7zvihZtpMtU
         RJFJcF7baslgKfLlbmePYVIHHF0UC8gYI4ooM8KLCvodEz1+Ou8kASlQzcyHoR6TwuC8
         cboOtIWuWtOO19Ur/UR8TQyF2D+YBAaynMMoSnAEXsYPgs1Sb80NpgOZ348H4ikO7OFF
         v6wMzubrByV/v4uJSSEtyjR/4WE4+eETDwVMiKnfEO2wE0Jq+NlgtEAM1lfPiiq2tu59
         zMfGuaOIg7mmJJMxnzMF1wMPVKac1ZMm9BXUM5GNj6G4gjT3oy8rw7DbwW4BEg0FWHI5
         XNVw==
X-Gm-Message-State: AOJu0YyCNKuon1esFZFAYQEMW3qiozdvB3slzBcv6COOX/rhQzlG7DIA
	3Vt0juAqzxhav7lJ0yz+E7hL3hZKYxmW96Nd87zm5w==
X-Google-Smtp-Source: AGHT+IHEHIq7dJJQu3e5Jy/+3w2noU5XNby30WDoYeYOHWWd4KG5y6Jppq/B04cpnM82XM1DlEwNoiXo/NzQmHo=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a25:8388:0:b0:dbd:7149:a389 with SMTP id
 t8-20020a258388000000b00dbd7149a389mr142790ybk.11.1704741390212; Mon, 08 Jan
 2024 11:16:30 -0800 (PST)
Date: Mon,  8 Jan 2024 19:16:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3559; i=rdbabiera@google.com;
 h=from:subject; bh=T6W1b6xfgTVUjTcJ8N2zILYWmciZGv0IRjajoRxiXJo=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKlzvFj6zSK8A8RUDrmeZHWe0vR4cZb9mbPs8RwR5o8VX
 y+VPNHdUcrCIMbBICumyKLrn2dw40rqljmcNcYwc1iZQIYwcHEKwESUuhkZ5jTnep8X2bxoeb70
 XqtpaUcLtDif8/06GbZufUVcpaS5AyND06yfvoX9PJfNd7GoeR+3fX43ocCA/9v9b2/38PM9Pqr JBQA=
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240108191620.987785-14-rdbabiera@google.com>
Subject: [PATCH v3 00/12] usb: typec: add SOP' support to the tcpm and alt
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

Changes since v2:
* Style changes, bugfix for lock in displayport.c, bugfix in tcpm.c that
  restores code deleted by patch.

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

 drivers/usb/typec/altmodes/displayport.c      |  162 ++-
 drivers/usb/typec/bus.c                       |  102 ++
 drivers/usb/typec/class.c                     |   59 +
 drivers/usb/typec/class.h                     |    1 +
 drivers/usb/typec/tcpm/fusb302.c              |    2 +-
 .../typec/tcpm/qcom/qcom_pmic_typec_pdphy.c   |    2 +-
 drivers/usb/typec/tcpm/tcpci.c                |   26 +-
 drivers/usb/typec/tcpm/tcpci_maxim.h          |    1 +
 drivers/usb/typec/tcpm/tcpci_maxim_core.c     |   38 +-
 drivers/usb/typec/tcpm/tcpm.c                 | 1030 ++++++++++++++---
 drivers/usb/typec/tcpm/wcove.c                |    2 +-
 include/linux/usb/pd.h                        |    1 +
 include/linux/usb/pd_vdo.h                    |    8 +-
 include/linux/usb/tcpci.h                     |   13 +
 include/linux/usb/tcpm.h                      |   16 +-
 include/linux/usb/typec.h                     |    7 +
 include/linux/usb/typec_altmode.h             |   30 +
 17 files changed, 1337 insertions(+), 163 deletions(-)


base-commit: 933bb7b878ddd0f8c094db45551a7daddf806e00
-- 
2.43.0.472.g3155946c3a-goog


