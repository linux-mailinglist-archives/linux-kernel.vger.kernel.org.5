Return-Path: <linux-kernel+bounces-153253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 831AD8ACB86
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FDCC1F23835
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340AB1448C7;
	Mon, 22 Apr 2024 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QX335Kx8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21BE1448E1;
	Mon, 22 Apr 2024 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783558; cv=none; b=EYKadRjxMLBOAE19cjWPY2br3DBTrlPLV+wFaGW+ie/TdoTKuOCwtDCEVwrnbmdtBg/mgQJxSAkZW5adm95vAZkMe2pZ2s6dg5SDbloAdg56w4c6ftqejHVA6LBORLydXNod4CGL0HAx3I/B6iSbVn9Zd+ZgowWS8Qkb2C4BKTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783558; c=relaxed/simple;
	bh=aW2SujkwHfCjrvrlgaow+xynTzvfPq67eqbp5gHD40E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/GxmeXeyHTnEb1Zt7ygYKU6MiX8zUO9kcLnNyLKG2hz7EKOmVvU3AGDpGBdOy0cz1ywdyL+kY10vfsLyUQCfjwrahO2kp/CfOZ4uTyug4tQz99Iha0BqJlJmasT4SXS/mMaTkTd0sxOMSY98Ua3So2zVfRBKG8v6tYhsubycpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QX335Kx8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713783556; x=1745319556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aW2SujkwHfCjrvrlgaow+xynTzvfPq67eqbp5gHD40E=;
  b=QX335Kx8gIjTp8Azu0chleG4HjzsZBGxjtvI3Y3oLnTIEAeNgdl9m5Ng
   IRJPGa05I+1qWAgrBTLAJDSPkNqf1dg0y7oi9UbcO/BxpIa4xAYeXdtdn
   K/crOBd3KujwWFHLGFW16tIF/u8QxKr4KxHpFpieKVQo6H/iXvQLKSGDZ
   kJytXBmVxCBOGyCENDu9uU2njXgNyfb0pV8GG0vVjIISO4VxHckR/OO5/
   D/HedsVI9DdkjASPN5ugHHbHHAjG3gIwA+tHmjTGcMDGpc85EekgNfFn/
   CKXK0Y0vhvb33oDjmY8xEjn97Spa8e7NQWLyc/Hbs/tRiVwCL3AGtpl4p
   g==;
X-CSE-ConnectionGUID: NjHq/gJOSyqzLtCwi6bK0Q==
X-CSE-MsgGUID: wOOMFj1VSzKoKnkeB5/iUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="9179894"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="9179894"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 03:59:15 -0700
X-CSE-ConnectionGUID: 1HBwcrCjTaGgMY1s2WlOzw==
X-CSE-MsgGUID: fVFVfVl3SaGvEgMXdqR1fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="24582062"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa008.jf.intel.com with SMTP; 22 Apr 2024 03:59:11 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 22 Apr 2024 13:59:10 +0300
Date: Mon, 22 Apr 2024 13:59:10 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 7/8] usb: typec: ucsi: glink: merge pmic_glink_altmode
 driver
Message-ID: <ZiZC/l9nOmzWx+j6@kuha.fi.intel.com>
References: <20240416-ucsi-glink-altmode-v1-0-890db00877ac@linaro.org>
 <20240416-ucsi-glink-altmode-v1-7-890db00877ac@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-ucsi-glink-altmode-v1-7-890db00877ac@linaro.org>

Hi Dmitry,

On Tue, Apr 16, 2024 at 05:20:56AM +0300, Dmitry Baryshkov wrote:
> Move handling of USB Altmode to the ucsi_glink driver. This way the
> altmode is properly registered in the Type-C framework, the altmode
> handlers can use generic typec calls, the UCSI driver can use
> orientation information from altmode messages and vice versa, the
> altmode handlers can use GPIO-based orientation inormation from UCSI
> GLINK driver.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/soc/qcom/Makefile             |   1 -
>  drivers/soc/qcom/pmic_glink_altmode.c | 546 ----------------------------------
>  drivers/usb/typec/ucsi/ucsi_glink.c   | 495 ++++++++++++++++++++++++++++--
>  3 files changed, 475 insertions(+), 567 deletions(-)
> 
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index ca0bece0dfff..d43d2b444634 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -9,7 +9,6 @@ obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
>  obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
>  obj-$(CONFIG_QCOM_PDR_HELPERS)	+= pdr_interface.o
>  obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink.o
> -obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink_altmode.o
>  obj-$(CONFIG_QCOM_PMIC_PDCHARGER_ULOG)	+= pmic_pdcharger_ulog.o
>  CFLAGS_pmic_pdcharger_ulog.o	:=  -I$(src)
>  obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
> diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
> deleted file mode 100644
> index b3808fc24c69..000000000000
> --- a/drivers/soc/qcom/pmic_glink_altmode.c
> +++ /dev/null
> @@ -1,546 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
> - * Copyright (c) 2022, Linaro Ltd
> - */
> -#include <linux/auxiliary_bus.h>
> -#include <linux/bitfield.h>
> -#include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
> -#include <linux/mutex.h>
> -#include <linux/property.h>
> -#include <linux/soc/qcom/pdr.h>
> -#include <drm/bridge/aux-bridge.h>
> -
> -#include <linux/usb/typec_altmode.h>
> -#include <linux/usb/typec_dp.h>
> -#include <linux/usb/typec_mux.h>
> -#include <linux/usb/typec_retimer.h>
> -
> -#include <linux/soc/qcom/pmic_glink.h>
> -
> -#define PMIC_GLINK_MAX_PORTS	2
> -
> -#define USBC_SC8180X_NOTIFY_IND	0x13
> -#define USBC_CMD_WRITE_REQ      0x15
> -#define USBC_NOTIFY_IND		0x16
> -
> -#define ALTMODE_PAN_EN		0x10
> -#define ALTMODE_PAN_ACK		0x11
> -
> -struct usbc_write_req {
> -	struct pmic_glink_hdr   hdr;
> -	__le32 cmd;
> -	__le32 arg;
> -	__le32 reserved;
> -};
> -
> -#define NOTIFY_PAYLOAD_SIZE 16
> -struct usbc_notify {
> -	struct pmic_glink_hdr hdr;
> -	char payload[NOTIFY_PAYLOAD_SIZE];
> -	u32 reserved;
> -};
> -
> -struct usbc_sc8180x_notify {
> -	struct pmic_glink_hdr hdr;
> -	__le32 notification;
> -	__le32 reserved[2];
> -};
> -
> -enum pmic_glink_altmode_pin_assignment {
> -	DPAM_HPD_OUT,
> -	DPAM_HPD_A,
> -	DPAM_HPD_B,
> -	DPAM_HPD_C,
> -	DPAM_HPD_D,
> -	DPAM_HPD_E,
> -	DPAM_HPD_F,
> -};
> -
> -struct pmic_glink_altmode;
> -
> -#define work_to_altmode_port(w) container_of((w), struct pmic_glink_altmode_port, work)
> -
> -struct pmic_glink_altmode_port {
> -	struct pmic_glink_altmode *altmode;
> -	unsigned int index;
> -
> -	struct typec_switch *typec_switch;
> -	struct typec_mux *typec_mux;
> -	struct typec_mux_state state;
> -	struct typec_retimer *typec_retimer;
> -	struct typec_retimer_state retimer_state;
> -	struct typec_altmode dp_alt;
> -
> -	struct work_struct work;
> -
> -	struct auxiliary_device *bridge;
> -
> -	enum typec_orientation orientation;
> -	u16 svid;
> -	u8 dp_data;
> -	u8 mode;
> -	u8 hpd_state;
> -	u8 hpd_irq;
> -};
> -
> -#define work_to_altmode(w) container_of((w), struct pmic_glink_altmode, enable_work)
> -
> -struct pmic_glink_altmode {
> -	struct device *dev;
> -
> -	unsigned int owner_id;
> -
> -	/* To synchronize WRITE_REQ acks */
> -	struct mutex lock;
> -
> -	struct completion pan_ack;
> -	struct pmic_glink_client *client;
> -
> -	struct work_struct enable_work;
> -
> -	struct pmic_glink_altmode_port ports[PMIC_GLINK_MAX_PORTS];
> -};
> -
> -static int pmic_glink_altmode_request(struct pmic_glink_altmode *altmode, u32 cmd, u32 arg)
> -{
> -	struct usbc_write_req req = {};
> -	unsigned long left;
> -	int ret;
> -
> -	/*
> -	 * The USBC_CMD_WRITE_REQ ack doesn't identify the request, so wait for
> -	 * one ack at a time.
> -	 */
> -	mutex_lock(&altmode->lock);
> -
> -	req.hdr.owner = cpu_to_le32(altmode->owner_id);
> -	req.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP);
> -	req.hdr.opcode = cpu_to_le32(USBC_CMD_WRITE_REQ);
> -	req.cmd = cpu_to_le32(cmd);
> -	req.arg = cpu_to_le32(arg);
> -
> -	ret = pmic_glink_send(altmode->client, &req, sizeof(req));
> -	if (ret) {
> -		dev_err(altmode->dev, "failed to send altmode request: %#x (%d)\n", cmd, ret);
> -		goto out_unlock;
> -	}
> -
> -	left = wait_for_completion_timeout(&altmode->pan_ack, 5 * HZ);
> -	if (!left) {
> -		dev_err(altmode->dev, "timeout waiting for altmode request ack for: %#x\n", cmd);
> -		ret = -ETIMEDOUT;
> -	}
> -
> -out_unlock:
> -	mutex_unlock(&altmode->lock);
> -	return ret;
> -}
> -
> -static void pmic_glink_altmode_enable_dp(struct pmic_glink_altmode *altmode,
> -					 struct pmic_glink_altmode_port *port,
> -					 u8 mode, bool hpd_state,
> -					 bool hpd_irq)
> -{
> -	struct typec_displayport_data dp_data = {};
> -	int ret;
> -
> -	dp_data.status = DP_STATUS_ENABLED;
> -	if (hpd_state)
> -		dp_data.status |= DP_STATUS_HPD_STATE;
> -	if (hpd_irq)
> -		dp_data.status |= DP_STATUS_IRQ_HPD;
> -	dp_data.conf = DP_CONF_SET_PIN_ASSIGN(mode);
> -
> -	port->state.alt = &port->dp_alt;
> -	port->state.data = &dp_data;
> -	port->state.mode = TYPEC_MODAL_STATE(mode);
> -
> -	ret = typec_mux_set(port->typec_mux, &port->state);
> -	if (ret)
> -		dev_err(altmode->dev, "failed to switch mux to DP: %d\n", ret);
> -
> -	port->retimer_state.alt = &port->dp_alt;
> -	port->retimer_state.data = &dp_data;
> -	port->retimer_state.mode = TYPEC_MODAL_STATE(mode);
> -
> -	ret = typec_retimer_set(port->typec_retimer, &port->retimer_state);
> -	if (ret)
> -		dev_err(altmode->dev, "failed to setup retimer to DP: %d\n", ret);
> -}
> -
> -static void pmic_glink_altmode_enable_usb(struct pmic_glink_altmode *altmode,
> -					  struct pmic_glink_altmode_port *port)
> -{
> -	int ret;
> -
> -	port->state.alt = NULL;
> -	port->state.data = NULL;
> -	port->state.mode = TYPEC_STATE_USB;
> -
> -	ret = typec_mux_set(port->typec_mux, &port->state);
> -	if (ret)
> -		dev_err(altmode->dev, "failed to switch mux to USB: %d\n", ret);
> -
> -	port->retimer_state.alt = NULL;
> -	port->retimer_state.data = NULL;
> -	port->retimer_state.mode = TYPEC_STATE_USB;
> -
> -	ret = typec_retimer_set(port->typec_retimer, &port->retimer_state);
> -	if (ret)
> -		dev_err(altmode->dev, "failed to setup retimer to USB: %d\n", ret);
> -}
> -
> -static void pmic_glink_altmode_safe(struct pmic_glink_altmode *altmode,
> -				    struct pmic_glink_altmode_port *port)
> -{
> -	int ret;
> -
> -	port->state.alt = NULL;
> -	port->state.data = NULL;
> -	port->state.mode = TYPEC_STATE_SAFE;
> -
> -	ret = typec_mux_set(port->typec_mux, &port->state);
> -	if (ret)
> -		dev_err(altmode->dev, "failed to switch mux to safe mode: %d\n", ret);
> -
> -	port->retimer_state.alt = NULL;
> -	port->retimer_state.data = NULL;
> -	port->retimer_state.mode = TYPEC_STATE_SAFE;
> -
> -	ret = typec_retimer_set(port->typec_retimer, &port->retimer_state);
> -	if (ret)
> -		dev_err(altmode->dev, "failed to setup retimer to USB: %d\n", ret);
> -}
> -
> -static void pmic_glink_altmode_worker(struct work_struct *work)
> -{
> -	struct pmic_glink_altmode_port *alt_port = work_to_altmode_port(work);
> -	struct pmic_glink_altmode *altmode = alt_port->altmode;
> -
> -	typec_switch_set(alt_port->typec_switch, alt_port->orientation);
> -
> -	if (alt_port->svid == USB_TYPEC_DP_SID && alt_port->mode == 0xff)
> -		pmic_glink_altmode_safe(altmode, alt_port);
> -	else if (alt_port->svid == USB_TYPEC_DP_SID)
> -		pmic_glink_altmode_enable_dp(altmode, alt_port, alt_port->mode,
> -					     alt_port->hpd_state, alt_port->hpd_irq);
> -	else
> -		pmic_glink_altmode_enable_usb(altmode, alt_port);
> -
> -	drm_aux_hpd_bridge_notify(&alt_port->bridge->dev,
> -				  alt_port->hpd_state ?
> -				  connector_status_connected :
> -				  connector_status_disconnected);
> -
> -	pmic_glink_altmode_request(altmode, ALTMODE_PAN_ACK, alt_port->index);
> -}
> -
> -static enum typec_orientation pmic_glink_altmode_orientation(unsigned int orientation)
> -{
> -	if (orientation == 0)
> -		return TYPEC_ORIENTATION_NORMAL;
> -	else if (orientation == 1)
> -		return TYPEC_ORIENTATION_REVERSE;
> -	else
> -		return TYPEC_ORIENTATION_NONE;
> -}
> -
> -#define SC8180X_PORT_MASK		0x000000ff
> -#define SC8180X_ORIENTATION_MASK	0x0000ff00
> -#define SC8180X_MUX_MASK		0x00ff0000
> -#define SC8180X_MODE_MASK		0x3f000000
> -#define SC8180X_HPD_STATE_MASK		0x40000000
> -#define SC8180X_HPD_IRQ_MASK		0x80000000
> -
> -static void pmic_glink_altmode_sc8180xp_notify(struct pmic_glink_altmode *altmode,
> -					       const void *data, size_t len)
> -{
> -	struct pmic_glink_altmode_port *alt_port;
> -	const struct usbc_sc8180x_notify *msg;
> -	u32 notification;
> -	u8 orientation;
> -	u8 hpd_state;
> -	u8 hpd_irq;
> -	u16 svid;
> -	u8 port;
> -	u8 mode;
> -	u8 mux;
> -
> -	if (len != sizeof(*msg)) {
> -		dev_warn(altmode->dev, "invalid length of USBC_NOTIFY indication: %zd\n", len);
> -		return;
> -	}
> -
> -	msg = data;
> -	notification = le32_to_cpu(msg->notification);
> -	port = FIELD_GET(SC8180X_PORT_MASK, notification);
> -	orientation = FIELD_GET(SC8180X_ORIENTATION_MASK, notification);
> -	mux = FIELD_GET(SC8180X_MUX_MASK, notification);
> -	mode = FIELD_GET(SC8180X_MODE_MASK, notification);
> -	hpd_state = FIELD_GET(SC8180X_HPD_STATE_MASK, notification);
> -	hpd_irq = FIELD_GET(SC8180X_HPD_IRQ_MASK, notification);
> -
> -	svid = mux == 2 ? USB_TYPEC_DP_SID : 0;
> -
> -	if (port >= ARRAY_SIZE(altmode->ports) || !altmode->ports[port].altmode) {
> -		dev_dbg(altmode->dev, "notification on undefined port %d\n", port);
> -		return;
> -	}
> -
> -	alt_port = &altmode->ports[port];
> -	alt_port->orientation = pmic_glink_altmode_orientation(orientation);
> -	alt_port->svid = svid;
> -	alt_port->mode = mode;
> -	alt_port->hpd_state = hpd_state;
> -	alt_port->hpd_irq = hpd_irq;
> -	schedule_work(&alt_port->work);
> -}
> -
> -#define SC8280XP_DPAM_MASK	0x3f
> -#define SC8280XP_HPD_STATE_MASK BIT(6)
> -#define SC8280XP_HPD_IRQ_MASK	BIT(7)
> -
> -static void pmic_glink_altmode_sc8280xp_notify(struct pmic_glink_altmode *altmode,
> -					       u16 svid, const void *data, size_t len)
> -{
> -	struct pmic_glink_altmode_port *alt_port;
> -	const struct usbc_notify *notify;
> -	u8 orientation;
> -	u8 hpd_state;
> -	u8 hpd_irq;
> -	u8 mode;
> -	u8 port;
> -
> -	if (len != sizeof(*notify)) {
> -		dev_warn(altmode->dev, "invalid length USBC_NOTIFY_IND: %zd\n",
> -			 len);
> -		return;
> -	}
> -
> -	notify = data;
> -
> -	port = notify->payload[0];
> -	orientation = notify->payload[1];
> -	mode = FIELD_GET(SC8280XP_DPAM_MASK, notify->payload[8]) - DPAM_HPD_A;
> -	hpd_state = FIELD_GET(SC8280XP_HPD_STATE_MASK, notify->payload[8]);
> -	hpd_irq = FIELD_GET(SC8280XP_HPD_IRQ_MASK, notify->payload[8]);
> -
> -	if (port >= ARRAY_SIZE(altmode->ports) || !altmode->ports[port].altmode) {
> -		dev_dbg(altmode->dev, "notification on undefined port %d\n", port);
> -		return;
> -	}
> -
> -	alt_port = &altmode->ports[port];
> -	alt_port->orientation = pmic_glink_altmode_orientation(orientation);
> -	alt_port->svid = svid;
> -	alt_port->mode = mode;
> -	alt_port->hpd_state = hpd_state;
> -	alt_port->hpd_irq = hpd_irq;
> -	schedule_work(&alt_port->work);
> -}
> -
> -static void pmic_glink_altmode_callback(const void *data, size_t len, void *priv)
> -{
> -	struct pmic_glink_altmode *altmode = priv;
> -	const struct pmic_glink_hdr *hdr = data;
> -	u16 opcode;
> -	u16 svid;
> -
> -	opcode = le32_to_cpu(hdr->opcode) & 0xff;
> -	svid = le32_to_cpu(hdr->opcode) >> 16;
> -
> -	switch (opcode) {
> -	case USBC_CMD_WRITE_REQ:
> -		complete(&altmode->pan_ack);
> -		break;
> -	case USBC_NOTIFY_IND:
> -		pmic_glink_altmode_sc8280xp_notify(altmode, svid, data, len);
> -		break;
> -	case USBC_SC8180X_NOTIFY_IND:
> -		pmic_glink_altmode_sc8180xp_notify(altmode, data, len);
> -		break;
> -	}
> -}
> -
> -static void pmic_glink_altmode_put_retimer(void *data)
> -{
> -	typec_retimer_put(data);
> -}
> -
> -static void pmic_glink_altmode_put_mux(void *data)
> -{
> -	typec_mux_put(data);
> -}
> -
> -static void pmic_glink_altmode_put_switch(void *data)
> -{
> -	typec_switch_put(data);
> -}
> -
> -static void pmic_glink_altmode_enable_worker(struct work_struct *work)
> -{
> -	struct pmic_glink_altmode *altmode = work_to_altmode(work);
> -	int ret;
> -
> -	ret = pmic_glink_altmode_request(altmode, ALTMODE_PAN_EN, 0);
> -	if (ret)
> -		dev_err(altmode->dev, "failed to request altmode notifications: %d\n", ret);
> -}
> -
> -static void pmic_glink_altmode_pdr_notify(void *priv, int state)
> -{
> -	struct pmic_glink_altmode *altmode = priv;
> -
> -	if (state == SERVREG_SERVICE_STATE_UP)
> -		schedule_work(&altmode->enable_work);
> -}
> -
> -static const struct of_device_id pmic_glink_altmode_of_quirks[] = {
> -	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)PMIC_GLINK_OWNER_USBC },
> -	{}
> -};
> -
> -static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
> -				    const struct auxiliary_device_id *id)
> -{
> -	struct pmic_glink_altmode_port *alt_port;
> -	struct pmic_glink_altmode *altmode;
> -	const struct of_device_id *match;
> -	struct fwnode_handle *fwnode;
> -	struct device *dev = &adev->dev;
> -	u32 port;
> -	int ret;
> -
> -	altmode = devm_kzalloc(dev, sizeof(*altmode), GFP_KERNEL);
> -	if (!altmode)
> -		return -ENOMEM;
> -
> -	altmode->dev = dev;
> -
> -	match = of_match_device(pmic_glink_altmode_of_quirks, dev->parent);
> -	if (match)
> -		altmode->owner_id = (unsigned long)match->data;
> -	else
> -		altmode->owner_id = PMIC_GLINK_OWNER_USBC_PAN;
> -
> -	INIT_WORK(&altmode->enable_work, pmic_glink_altmode_enable_worker);
> -	init_completion(&altmode->pan_ack);
> -	mutex_init(&altmode->lock);
> -
> -	device_for_each_child_node(dev, fwnode) {
> -		ret = fwnode_property_read_u32(fwnode, "reg", &port);
> -		if (ret < 0) {
> -			dev_err(dev, "missing reg property of %pOFn\n", fwnode);
> -			fwnode_handle_put(fwnode);
> -			return ret;
> -		}
> -
> -		if (port >= ARRAY_SIZE(altmode->ports)) {
> -			dev_warn(dev, "invalid connector number, ignoring\n");
> -			continue;
> -		}
> -
> -		if (altmode->ports[port].altmode) {
> -			dev_err(dev, "multiple connector definition for port %u\n", port);
> -			fwnode_handle_put(fwnode);
> -			return -EINVAL;
> -		}
> -
> -		alt_port = &altmode->ports[port];
> -		alt_port->altmode = altmode;
> -		alt_port->index = port;
> -		INIT_WORK(&alt_port->work, pmic_glink_altmode_worker);
> -
> -		alt_port->bridge = devm_drm_dp_hpd_bridge_alloc(dev, to_of_node(fwnode));
> -		if (IS_ERR(alt_port->bridge)) {
> -			fwnode_handle_put(fwnode);
> -			return PTR_ERR(alt_port->bridge);
> -		}
> -
> -		alt_port->dp_alt.svid = USB_TYPEC_DP_SID;
> -		alt_port->dp_alt.mode = USB_TYPEC_DP_MODE;
> -		alt_port->dp_alt.active = 1;
> -
> -		alt_port->typec_mux = fwnode_typec_mux_get(fwnode);
> -		if (IS_ERR(alt_port->typec_mux)) {
> -			fwnode_handle_put(fwnode);
> -			return dev_err_probe(dev, PTR_ERR(alt_port->typec_mux),
> -					     "failed to acquire mode-switch for port: %d\n",
> -					     port);
> -		}
> -
> -		ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_mux,
> -					       alt_port->typec_mux);
> -		if (ret) {
> -			fwnode_handle_put(fwnode);
> -			return ret;
> -		}
> -
> -		alt_port->typec_retimer = fwnode_typec_retimer_get(fwnode);
> -		if (IS_ERR(alt_port->typec_retimer)) {
> -			fwnode_handle_put(fwnode);
> -			return dev_err_probe(dev, PTR_ERR(alt_port->typec_retimer),
> -					     "failed to acquire retimer-switch for port: %d\n",
> -					     port);
> -		}
> -
> -		ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_retimer,
> -					       alt_port->typec_retimer);
> -		if (ret) {
> -			fwnode_handle_put(fwnode);
> -			return ret;
> -		}
> -
> -		alt_port->typec_switch = fwnode_typec_switch_get(fwnode);
> -		if (IS_ERR(alt_port->typec_switch)) {
> -			fwnode_handle_put(fwnode);
> -			return dev_err_probe(dev, PTR_ERR(alt_port->typec_switch),
> -					     "failed to acquire orientation-switch for port: %d\n",
> -					     port);
> -		}
> -
> -		ret = devm_add_action_or_reset(dev, pmic_glink_altmode_put_switch,
> -					       alt_port->typec_switch);
> -		if (ret) {
> -			fwnode_handle_put(fwnode);
> -			return ret;
> -		}
> -	}
> -
> -	for (port = 0; port < ARRAY_SIZE(altmode->ports); port++) {
> -		alt_port = &altmode->ports[port];
> -		if (!alt_port->bridge)
> -			continue;
> -
> -		ret = devm_drm_dp_hpd_bridge_add(dev, alt_port->bridge);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	altmode->client = devm_pmic_glink_register_client(dev,
> -							  altmode->owner_id,
> -							  pmic_glink_altmode_callback,
> -							  pmic_glink_altmode_pdr_notify,
> -							  altmode);
> -	return PTR_ERR_OR_ZERO(altmode->client);
> -}
> -
> -static const struct auxiliary_device_id pmic_glink_altmode_id_table[] = {
> -	{ .name = "pmic_glink.altmode", },
> -	{},
> -};
> -MODULE_DEVICE_TABLE(auxiliary, pmic_glink_altmode_id_table);
> -
> -static struct auxiliary_driver pmic_glink_altmode_driver = {
> -	.name = "pmic_glink_altmode",
> -	.probe = pmic_glink_altmode_probe,
> -	.id_table = pmic_glink_altmode_id_table,
> -};
> -
> -module_auxiliary_driver(pmic_glink_altmode_driver);
> -
> -MODULE_DESCRIPTION("Qualcomm PMIC GLINK Altmode driver");
> -MODULE_LICENSE("GPL");
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index 40fcda055b05..1ef638d5fd79 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -10,9 +10,14 @@
>  #include <linux/of_device.h>
>  #include <linux/property.h>
>  #include <linux/soc/qcom/pdr.h>
> +#include <linux/usb/pd_vdo.h>
> +#include <linux/usb/typec_dp.h>
>  #include <linux/usb/typec_mux.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/soc/qcom/pmic_glink.h>
> +
> +#include <drm/bridge/aux-bridge.h>
> +
>  #include "ucsi.h"
>  
>  #define PMIC_GLINK_MAX_PORTS	2
> @@ -27,6 +32,16 @@
>  #define UC_UCSI_WRITE_BUF_REQ           0x12
>  #define UC_UCSI_USBC_NOTIFY_IND         0x13
>  
> +/*
> + * On sc8180x these requests use UCSI owner,
> + * on other platforms they use USBC_PAN.
> + */
> +#define USBC_CMD_WRITE_REQ		0x15
> +#define USBC_PAN_NOTIFY_IND		0x16
> +
> +#define ALTMODE_PAN_EN		0x10
> +#define ALTMODE_PAN_ACK		0x11
> +
>  struct ucsi_read_buf_req_msg {
>  	struct pmic_glink_hdr   hdr;
>  };
> @@ -55,17 +70,89 @@ struct ucsi_notify_ind_msg {
>  	u32                     reserved;
>  };
>  
> +struct usbc_write_req_msg {
> +	struct pmic_glink_hdr   hdr;
> +	__le32			cmd;
> +	__le32			arg;
> +	u32                     reserved;
> +};
> +
> +#define USBC_NOTIFY_PAYLOAD_SIZE 16
> +struct usbc_pan_notify_ind_msg {
> +	struct pmic_glink_hdr	hdr;
> +	char			payload[USBC_NOTIFY_PAYLOAD_SIZE];
> +	u32			reserved;
> +};
> +
> +enum pmic_glink_ucsi_orientation {
> +	USBC_ORIENTATION_NORMAL,
> +	USBC_ORIENTATION_REVERSE,
> +	USBC_ORIENTATION_NONE,
> +};
> +
> +enum pmic_glink_ucsi_mux {
> +	USBC_MUX_NONE,
> +	USBC_MUX_USB_2L,
> +	USBC_MUX_DP_4L,
> +	USBC_MUX_USB_DP,
> +};
> +
> +enum pmic_glink_altmode_pin_assignment {
> +	DPAM_HPD_OUT,
> +	DPAM_HPD_A,
> +	DPAM_HPD_B,
> +	DPAM_HPD_C,
> +	DPAM_HPD_D,
> +	DPAM_HPD_E,
> +	DPAM_HPD_F,
> +};
> +
> +#define SC8180X_PORT_MASK		GENMASK(7, 0)
> +#define SC8180X_ORIENTATION_MASK	GENMASK(15, 8)
> +#define SC8180X_MUX_MASK		GENMASK(23, 16)
> +#define SC8180X_MODE_MASK		GENMASK(29, 24)
> +#define SC8180X_HPD_STATE_MASK		BIT(30)
> +#define SC8180X_HPD_IRQ_MASK		BIT(31)
> +
> +#define SC8280XP_DPAM_MASK		GENMASK(5, 0)
> +#define SC8280XP_HPD_STATE_MASK		BIT(6)
> +#define SC8280XP_HPD_IRQ_MASK		BIT(7)
> +
> +struct pmic_glink_ucsi_port {
> +	spinlock_t lock;
> +
> +	struct work_struct altmode_work;
> +
> +	struct pmic_glink_ucsi *ucsi;
> +	struct gpio_desc *port_orientation;
> +	struct auxiliary_device *bridge;
> +
> +	int idx;
> +
> +	enum typec_orientation orientation;
> +
> +	enum pmic_glink_ucsi_mux mux;
> +	unsigned int mode;
> +
> +	u16 svid;
> +	u8 hpd_state;
> +	u8 hpd_irq;
> +};
> +
>  struct pmic_glink_ucsi {
>  	struct device *dev;
>  
> -	struct gpio_desc *port_orientation[PMIC_GLINK_MAX_PORTS];
> +	struct pmic_glink_ucsi_port ports[PMIC_GLINK_MAX_PORTS];
>  
> +	unsigned int altmode_id;
> +	struct pmic_glink_client *altmode_client;
>  	struct pmic_glink_client *client;
>  
>  	struct ucsi *ucsi;
>  	struct completion read_ack;
>  	struct completion write_ack;
>  	struct completion sync_ack;
> +	struct completion pan_ack;
>  	bool sync_pending;
>  	struct mutex lock;	/* protects concurrent access to PMIC Glink interface */
>  
> @@ -193,27 +280,128 @@ static void pmic_glink_ucsi_update_connector(struct ucsi_connector *con)
>  	int i;
>  
>  	for (i = 0; i < PMIC_GLINK_MAX_PORTS; i++) {
> -		if (ucsi->port_orientation[i])
> +		if (ucsi->ports[i].port_orientation)
>  			con->typec_cap.orientation_aware = true;
>  	}
>  }
>  
> +static int pmic_glink_altmode_request(struct pmic_glink_ucsi *ucsi, u32 cmd, u32 arg)
> +{
> +	struct usbc_write_req_msg req = {};
> +	unsigned long left;
> +	int ret;
> +
> +	/*
> +	 * The USBC_CMD_WRITE_REQ ack doesn't identify the request, so wait for
> +	 * one ack at a time.
> +	 */
> +	mutex_lock(&ucsi->lock);
> +
> +	req.hdr.owner = cpu_to_le32(ucsi->altmode_id);
> +	req.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP);
> +	req.hdr.opcode = cpu_to_le32(USBC_CMD_WRITE_REQ);
> +	req.cmd = cpu_to_le32(cmd);
> +	req.arg = cpu_to_le32(arg);
> +
> +	reinit_completion(&ucsi->pan_ack);
> +	ret = pmic_glink_send(ucsi->altmode_client, &req, sizeof(req));
> +	if (ret) {
> +		dev_err(ucsi->dev, "failed to send altmode request: %#x (%d)\n", cmd, ret);
> +		goto out_unlock;
> +	}
> +
> +	left = wait_for_completion_timeout(&ucsi->pan_ack, 5 * HZ);
> +	if (!left) {
> +		dev_err(ucsi->dev, "timeout waiting for altmode request ack for: %#x\n", cmd);
> +		ret = -ETIMEDOUT;
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&ucsi->lock);
> +	return ret;
> +}
> +
> +static void pmic_glink_ucsi_set_orientation(struct ucsi_connector *con,
> +					    struct pmic_glink_ucsi_port *port)
> +{
> +	enum typec_orientation orientation;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +	orientation = port->orientation;
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	if (port->port_orientation) {
> +		int val = gpiod_get_value(port->port_orientation);
> +		if (val >= 0)
> +			orientation = val ?
> +				TYPEC_ORIENTATION_REVERSE :
> +				TYPEC_ORIENTATION_NORMAL;
> +	}
> +
> +	typec_set_orientation(con->port, orientation);
> +}
> +
>  static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
>  {
>  	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(con->ucsi);
> -	int orientation;
>  
> -	if (con->num >= PMIC_GLINK_MAX_PORTS ||
> -	    !ucsi->port_orientation[con->num - 1])
> +	if (con->num >= PMIC_GLINK_MAX_PORTS)
>  		return;
>  
> -	orientation = gpiod_get_value(ucsi->port_orientation[con->num - 1]);
> -	if (orientation >= 0) {
> -		typec_set_orientation(con->port,
> -				      orientation ?
> -				      TYPEC_ORIENTATION_REVERSE :
> -				      TYPEC_ORIENTATION_NORMAL);
> -	}
> +	pmic_glink_ucsi_set_orientation(con, &ucsi->ports[con->num - 1]);
> +}
> +
> +static void pmic_glink_ucsi_register_altmode(struct ucsi_connector *con)
> +{
> +	static const u8 all_assignments = BIT(DP_PIN_ASSIGN_C) | BIT(DP_PIN_ASSIGN_D) |
> +			     BIT(DP_PIN_ASSIGN_E);
> +	struct typec_altmode_desc desc;
> +	struct typec_altmode *alt;
> +
> +	mutex_lock(&con->lock);
> +
> +	if (con->port_altmode[0])
> +		goto out;
> +
> +	memset(&desc, 0, sizeof(desc));
> +	desc.svid = USB_TYPEC_DP_SID;
> +	desc.mode = USB_TYPEC_DP_MODE;
> +
> +	desc.vdo = DP_CAP_CAPABILITY(DP_CAP_DFP_D);
> +
> +	/* We can't rely on the firmware with the capabilities. */
> +	desc.vdo |= DP_CAP_DP_SIGNALLING(0) | DP_CAP_RECEPTACLE;
> +
> +	/* Claiming that we support all pin assignments */
> +	desc.vdo |= all_assignments << 8;
> +	desc.vdo |= all_assignments << 16;
> +
> +	alt = typec_port_register_altmode(con->port, &desc);

        alt = ucsi_register_displayport(con, 0, 0, &desc);

You need to export that function, but that should not be a problem:

diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index d9d3c91125ca..f2754d7b5876 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -315,11 +315,13 @@ struct typec_altmode *ucsi_register_displayport(struct ucsi_connector *con,
        struct ucsi_dp *dp;
 
        /* We can't rely on the firmware with the capabilities. */
-       desc->vdo |= DP_CAP_DP_SIGNALLING(0) | DP_CAP_RECEPTACLE;
+       if (!desc->vdo) {
+               desc->vdo = DP_CAP_DP_SIGNALLING(0) | DP_CAP_RECEPTACLE;
 
-       /* Claiming that we support all pin assignments */
-       desc->vdo |= all_assignments << 8;
-       desc->vdo |= all_assignments << 16;
+               /* Claiming that we support all pin assignments */
+               desc->vdo |= all_assignments << 8;
+               desc->vdo |= all_assignments << 16;
+       }
 
        alt = typec_port_register_altmode(con->port, desc);
        if (IS_ERR(alt))
@@ -342,3 +344,4 @@ struct typec_altmode *ucsi_register_displayport(struct ucsi_connector *con,
 
        return alt;
 }
+EXPORT_SYMBOL_GPL(ucsi_register_displayport);

<snip>

> +static void pmic_glink_ucsi_set_state(struct ucsi_connector *con,
> +				      struct pmic_glink_ucsi_port *port)
> +{
> +	struct typec_displayport_data dp_data = {};
> +	struct typec_altmode *altmode = NULL;
> +	unsigned long flags;
> +	void *data = NULL;
> +	int mode;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	if (port->svid == USB_SID_PD) {
> +		mode = TYPEC_STATE_USB;
> +	} else if (port->svid == USB_TYPEC_DP_SID && port->mode == DPAM_HPD_OUT) {
> +		mode = TYPEC_STATE_SAFE;
> +	} else if (port->svid == USB_TYPEC_DP_SID) {
> +		altmode = find_altmode(con, port->svid);
> +		if (!altmode) {
> +			dev_err(con->ucsi->dev, "altmode woth SVID 0x%04x not found\n",
> +				port->svid);
> +			spin_unlock_irqrestore(&port->lock, flags);
> +			return;
> +		}
> +
> +		mode = TYPEC_MODAL_STATE(port->mode - DPAM_HPD_A);
> +
> +		dp_data.status = DP_STATUS_ENABLED;
> +		dp_data.status |= DP_STATUS_CON_DFP_D;
> +		if (port->hpd_state)
> +			dp_data.status |= DP_STATUS_HPD_STATE;
> +		if (port->hpd_irq)
> +			dp_data.status |= DP_STATUS_IRQ_HPD;
> +		dp_data.conf = DP_CONF_SET_PIN_ASSIGN(port->mode - DPAM_HPD_A);
> +
> +		data = &dp_data;
> +	} else {
> +		dev_err(con->ucsi->dev, "Unsupported SVID 0x%04x\n", port->svid);
> +		spin_unlock_irqrestore(&port->lock, flags);
> +		return;
> +	}
> +
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	if (altmode)
> +		typec_altmode_set_port(altmode, mode, data);

So if the port altmode is using the ucsi_displayport_ops, you can
simply register the partner altmode here instead. That should
guarantee that it'll bind to the DP altmode driver which will take
care of typec_altmode_enter() etc.

This will also allow the user space to see the altmode normally in
sysfs.

> +	else
> +		typec_set_mode(con->port, mode);
> +
> +	if (port->bridge)
> +		drm_aux_hpd_bridge_notify(&port->bridge->dev,
> +					  port->hpd_state ?
> +					  connector_status_connected :
> +					  connector_status_disconnected);
> +
> +}

thanks,

-- 
heikki

