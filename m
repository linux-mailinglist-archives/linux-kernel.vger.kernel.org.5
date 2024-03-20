Return-Path: <linux-kernel+bounces-108419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28282880A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6491F235CF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 04:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218181428F;
	Wed, 20 Mar 2024 04:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=turingpi.com header.i=@turingpi.com header.b="jW35wPlH"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28B31400A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 04:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710908420; cv=none; b=H9fhvS7HQWAA8EEdgGetSjLrKF55GdGFaWoFGp4iX7m83uI7dHrtz9NZMebuGtzc4c49yBH/wdC1zb9WUtUwe+W6hhNEp8tghzMno7FLFqPSlYVBcidoua1/DJeo0pDciMAj+l5fWXZUX/tI0AAGqWin7Mj1oPj+3rtJ/lTSuZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710908420; c=relaxed/simple;
	bh=H/oWAmb3qdH6GqOGd7i1JdAe4XTSZAqLaJD9s7aHPtk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ue+4c7onulOaIdMcmkHfw24UeFgxK7aupIA57xjfBSntuYb3a73O7bmGv7PJnn7hFbL7Vm2UuK4a4wDXU4ro7wyxiVChjH8k28nZQ/o9RDLa+xvbdqrRXehk782Ztt+z8ikiK1JLNTgyOPOQdYwiAlMO1jmBq3FbTlXMMholzbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=turingpi.com; spf=pass smtp.mailfrom=turingpi.com; dkim=pass (2048-bit key) header.d=turingpi.com header.i=@turingpi.com header.b=jW35wPlH; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=turingpi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=turingpi.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e7425a6714so1269615b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=turingpi.com; s=google; t=1710908418; x=1711513218; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x/ne4R6QNYBHc5s1C1wG8NSPymgeCplkIkbc0sb+CmI=;
        b=jW35wPlHXg3qlupWIcHLVQjTLb6Vz+uFu8/YqZrbFSYh0rq7qTfBFO3tYiDxLZSqYN
         nYMzj8lBwk8KWhFB280YimQ9i35wxHBj2kfE3PG31VsRi9C38y4JqlUVq3uzA5uOM2f6
         hjLZon7MlgTRXyInBNZEBFeDuQ0rMFq6eyIlo1wJpg1VHPDt1q2ZOu3qGQADw/XJjut1
         KDCQ0EPQ9F1uHw60tZKYEC8NzDE2fB5WEkNK1AeyeXqxtkW3yX7NCmVMSkkxn4vV5Ofv
         EpEGdvCmgycDYAprthqMPOALOp1XPDjEEb/Od2fQ9ISiuEY7lFBPUVW0vJl1nEhD5qQy
         QUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710908418; x=1711513218;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x/ne4R6QNYBHc5s1C1wG8NSPymgeCplkIkbc0sb+CmI=;
        b=epoly3cEnzaUaz6OV6bPygA22YgrWGJAmwVmVA4Demyn/cCNajNsYwhLGCHQWR9x0n
         j2FOY8y2ToqY8RrdeCjLYrnm+Kw4Zsyk9+9Vk7PSe1dD6LFGYdzMt73d50jVkPkyA3Yy
         X4HQuVdvgl/rxp4LMQVe/k6T+BeBeoecjPMuOgZ/Zj1KinIx6x9BrLb9hw0qNAxvE/HW
         gCGd/dOjJczRNzrO9t5bmhXCFpj1HmyxMvRWtI8fWbM0B5A9KlUOz53sl82pdKoMh4Mm
         Acua5y6CMoj7Ak88MRLk6zPfHKrJvGR09wJKi1JiJP4w0G2tQMvP5/9QRjifN/n99rZR
         oSEg==
X-Forwarded-Encrypted: i=1; AJvYcCWLHzEJyQTWVFKbz92mCQsIdqZxNkXTKJELYPNOMIEb1fuqdxjEnHHQhSOSCxdM0l/muBwyM/NphVlr8XmxXHMMcEo3risBcyx5Z4J5
X-Gm-Message-State: AOJu0YyRMmaReO3HXxyxqPEh8SOFT+U3rhOvD7YAfmDluaQ2BiZSfJDE
	JOYnIzHBqavt46nVSC5/q/GNQbMEhf5mbEgvj/pkd4aDXPmwGJ7u167UdRdwym6HXKMW7VZf8Kp
	auTILB78TLcATBvUtEM8OjIiJKUCaGE/Iruljsw==
X-Google-Smtp-Source: AGHT+IHff6ZCZ3a77kNIs1sj3YhQ2PuSoZWxg+6jNDPEOpMuOBgzBIEK6UEkagTBVQCJexujrskf7gcN6CxbhnGJtxg=
X-Received: by 2002:a05:6a20:7351:b0:1a3:6833:1ccb with SMTP id
 v17-20020a056a20735100b001a368331ccbmr1039918pzc.40.1710908418227; Tue, 19
 Mar 2024 21:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sam Edwards <sam@turingpi.com>
Date: Tue, 19 Mar 2024 22:20:07 -0600
Message-ID: <CAF8uH3tRCACX23CyA=M+AYq4YRsf3P97eL=0k8Rdg1UACREY_g@mail.gmail.com>
Subject: [RESEND RFC PATCH 1/5] i2c: mv64xxx: Clear bus errors before transfer
To: Gregory CLEMENT <gregory.clement@bootlin.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The MV64XXX hardware can act as either a bus controller or target
device. In order to protect target devices from a glitching bus
(apparently), the core listens on the lines even when idle and moves the
hardware FSM to the "BUS_ERR" state if an invalid transition is
detected. The hardware then does not exit this state until reset.

This feature is actually counterproductive when using the hardware as a
controller (as this driver does): we do not actually *care* what
happened on the bus previously, as long as it's ready for use when the
new transfer starts. However, the controller will remember a previous
glitch and trip up the driver after it attempts to send the start
command. The driver logs and error and resets the controller, recovering
from the BUS_ERR state, but not without erroring back the transfer with
errno EAGAIN. Clients generally do not handle this gracefully.

This is easily fixed by checking for the BUS_ERR condition upfront and
issuing the hardware reset before beginning the transfer. This patch
does NOT also call i2c_recover_bus(): the assumption is that the bus is
fine, just the hardware is upset; if the bus is also in a bad state,
this should not pass silently.

Signed-off-by: Sam Edwards <sam@turingpi.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index fd8403b07fa6..cfc16909fba3 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -753,6 +753,7 @@ mv64xxx_i2c_xfer_core(struct i2c_adapter *adap,
struct i2c_msg msgs[], int num)
 {
        struct mv64xxx_i2c_data *drv_data = i2c_get_adapdata(adap);
        int rc, ret = num;
+       u32 status;

        rc = pm_runtime_resume_and_get(&adap->dev);
        if (rc)
@@ -762,6 +763,11 @@ mv64xxx_i2c_xfer_core(struct i2c_adapter *adap,
struct i2c_msg msgs[], int num)
        drv_data->msgs = msgs;
        drv_data->num_msgs = num;

+       /* Calm down the hardware if it was upset by a bus glitch while idle */
+       status = readl(drv_data->reg_base + drv_data->reg_offsets.status);
+       if (status == MV64XXX_I2C_STATUS_BUS_ERR)
+               mv64xxx_i2c_hw_init(drv_data);
+
        if (mv64xxx_i2c_can_offload(drv_data) && !drv_data->atomic)
                rc = mv64xxx_i2c_offload_xfer(drv_data);
        else
--
2.43.2

