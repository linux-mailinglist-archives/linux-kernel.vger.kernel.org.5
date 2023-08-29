Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF43178CEF9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbjH2Vud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238511AbjH2VuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:50:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9452ECC0;
        Tue, 29 Aug 2023 14:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.us;
 s=s31663417; t=1693345763; x=1693950563; i=fan.ni@gmx.us;
 bh=E0d/5x/RmE517ERqUPY+Iqcr/9gBktMSOn8LBSbCfQ0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=kcu/RKady7pp/Ab23TjYDeKiABljeNbqjppR3ccdpEDoIqVJxdUcNBi7kknmMoydzLuPoHr
 OvRStfbqIhGu3WKQxAbOm/QO84aMs9CK3VjTjxdbUvv0DeiuM+O8gP/+yqzT0gGBYeWxkp9dn
 GymfXUDJU8eGq3cR+DGjGwIG0UzBggZd197EBsHgPzvPy+iV4sSBdpw9MTxzjBIQO/m28sKDX
 roNd9rsVddCuXtqjXzuPyNf3/plMkGPt5cgtDZl0FTO0AaZJamY9EUzxZ63aV8mL9LIOoWVmJ
 vzh64nGbugRTJF+ENiUYLN2Gf9DOkIDOSwNIU9A/wi4y1Kue045Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from debian ([50.205.20.42]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHGCo-1qWgja0xLk-00DJwF; Tue, 29
 Aug 2023 23:49:22 +0200
Date:   Tue, 29 Aug 2023 14:49:15 -0700
From:   Fan Ni <fan.ni@gmx.us>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 02/18] cxl/mbox: Flag support for Dynamic Capacity
 Devices (DCD)
Message-ID: <ZO5n2+Kc+VpWXMlk@debian>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-2-f740c47e7916@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604-dcd-type2-upstream-v2-2-f740c47e7916@intel.com>
X-Provags-ID: V03:K1:YoAvlo2RfG5dULrcWzNlH9zDToUU3T+J3eqxkZ+OpHaXLoqMusA
 k5RlOuADzCm6OTy4FtcwJ2b4sVBsfToNqwo4FKlr65PfZu897/qJbw8wTm5TJede4RohCcj
 eu53KYERdmnMvwUyoF2GwQS9lRfwBh1Y7/0Q+dA/n2b2ZGA2BMAKKF9NRLeHYT4x4SGnQlM
 KdLjMPT3zj7WHyjqzROtA==
UI-OutboundReport: notjunk:1;M01:P0:mJ87uB9AMqY=;lwrlQ/ra4pPz5PMy/Nt8klMyHm9
 qsaKkxKmKSsNbWzaQZqQGPiXPkjS89BUkxSPLp5PGNuOCdVWAw9gWc5RQJREKDBEWeHOqs8Pc
 uh4wotJbjNMa0w96xlHuV/qoFhU2A8X6Ux0SHmdyTCIVO8NNZVwq/6y+yZpGi3lUKuarm76OF
 oyEzPrtXMCSR8UfvaXRV2TSG3t9cal4Q+1M9t5bQ0bo8WsHV6mD2PuWeKKRFvEGfpq7sDufPQ
 Y2lOucS0S1VnYlgN0lSmlsFwIxY1jQ1dxHEqPcYLrBnl/psFpvMYmwou2VCJF2NCydVleF6WF
 rGnNQ9JIHG8u4jl/hufh4Aia0ymxvOvmT8q2WFPv+TaoA8XgQ9qmHWx9pMe/t92wN5kWmHVZ2
 opiIAr6rBJ+7VVwbmUWXhE5JQ/KZ4uifch49aLZm/39cJKVqr6d7hTFaByF0ne5rvjwv8WaHn
 yLkTl+E8nmDpnY0rUoYC2X/WhUTbJUs5lx/b7N36l/etMat3hBrI4Wqgh3Yb7KVYE6qU7tAzO
 m/+qPdLxVkXWfvIL7CVepau6rUP0WGRl7+PVbMKASyHuL46inPbyrxl8P/TAx/U0WKjv/uMwJ
 IGZnU6RDZduXtUZsHZzvEjFEvbpIbvrvxoFi5fxiB2bw63nVBdbXLKHptEfuRQrX6Q9K1p0O9
 xnFNV+yUznu5k/yLBa3inCtZdB2rl9A1BWHuKYTDEm3tyrSyo9+Y9JsAvN2v9m7l771EE0vP7
 BQkNQjcp6Hi4/BwJPnieGKPwmbPYVzTLEo7oF3ZAfe04CNgvywfaIG/dOAKvpfHoAkNsJZN6q
 cxlGXwG+p7ooypyEZ7OmP+aAIFw+SoXqdNk46094ZHXP56o4uSCBAL8FngYpWzh8n5WZmD5/W
 FVv2F15e50IYwRybTr42zFsf6/UEXfiTl0cWt99f2ZV3c3Xb832rZGYfXMxTFF2G66z9TSAON
 e/Kp75DBbiUfPEJP9jEw9hEALDA=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:20:53PM -0700, Ira Weiny wrote:
> Per the CXL 3.0 specification software must check the Command Effects
> Log (CEL) to know if a device supports DC.  If the device does support
> DC the specifics of the DC Regions (0-7) are read through the mailbox.
>
> Flag DC Device (DCD) commands in a device if they are supported.
> Subsequent patches will key off these bits to configure a DCD.
>
> Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
> Changes for v2
> [iweiny: new patch]
> ---
>  drivers/cxl/core/mbox.c | 38 +++++++++++++++++++++++++++++++++++---
>  drivers/cxl/cxlmem.h    | 15 +++++++++++++++
>  2 files changed, 50 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f052d5f174ee..554ec97a7c39 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -111,6 +111,34 @@ static u8 security_command_sets[] =3D {
>  	0x46, /* Security Passthrough */
>  };
>
> +static bool cxl_is_dcd_command(u16 opcode)
> +{
> +#define CXL_MBOX_OP_DCD_CMDS 0x48
> +
> +	return (opcode >> 8) =3D=3D CXL_MBOX_OP_DCD_CMDS;
> +}
> +
> +static void cxl_set_dcd_cmd_enabled(struct cxl_memdev_state *mds,
> +					u16 opcode)
> +{
> +	switch (opcode) {
> +	case CXL_MBOX_OP_GET_DC_CONFIG:
> +		set_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
> +		break;
> +	case CXL_MBOX_OP_GET_DC_EXTENT_LIST:
> +		set_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds);
> +		break;
> +	case CXL_MBOX_OP_ADD_DC_RESPONSE:
> +		set_bit(CXL_DCD_ENABLED_ADD_RESPONSE, mds->dcd_cmds);
> +		break;
> +	case CXL_MBOX_OP_RELEASE_DC:
> +		set_bit(CXL_DCD_ENABLED_RELEASE, mds->dcd_cmds);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static bool cxl_is_security_command(u16 opcode)
>  {
>  	int i;
> @@ -677,9 +705,10 @@ static void cxl_walk_cel(struct cxl_memdev_state *m=
ds, size_t size, u8 *cel)
>  		u16 opcode =3D le16_to_cpu(cel_entry[i].opcode);
>  		struct cxl_mem_command *cmd =3D cxl_mem_find_command(opcode);
>
> -		if (!cmd && !cxl_is_poison_command(opcode)) {
> -			dev_dbg(dev,
> -				"Opcode 0x%04x unsupported by driver\n", opcode);
> +		if (!cmd && !cxl_is_poison_command(opcode) &&
> +		    !cxl_is_dcd_command(opcode)) {
> +			dev_dbg(dev, "Opcode 0x%04x unsupported by driver\n",
> +				opcode);
>  			continue;
>  		}
>
> @@ -689,6 +718,9 @@ static void cxl_walk_cel(struct cxl_memdev_state *md=
s, size_t size, u8 *cel)
>  		if (cxl_is_poison_command(opcode))
>  			cxl_set_poison_cmd_enabled(&mds->poison, opcode);
>
> +		if (cxl_is_dcd_command(opcode))
> +			cxl_set_dcd_cmd_enabled(mds, opcode);
> +
>  		dev_dbg(dev, "Opcode 0x%04x enabled\n", opcode);
>  	}
>  }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index adfba72445fc..5f2e65204bf9 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -247,6 +247,15 @@ struct cxl_event_state {
>  	struct mutex log_lock;
>  };
>
> +/* Device enabled DCD commands */
> +enum dcd_cmd_enabled_bits {
> +	CXL_DCD_ENABLED_GET_CONFIG,
> +	CXL_DCD_ENABLED_GET_EXTENT_LIST,
> +	CXL_DCD_ENABLED_ADD_RESPONSE,
> +	CXL_DCD_ENABLED_RELEASE,
> +	CXL_DCD_ENABLED_MAX
> +};
> +
>  /* Device enabled poison commands */
>  enum poison_cmd_enabled_bits {
>  	CXL_POISON_ENABLED_LIST,
> @@ -436,6 +445,7 @@ struct cxl_dev_state {
>   *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
>   * @mbox_mutex: Mutex to synchronize mailbox access.
>   * @firmware_version: Firmware version for the memory device.
> + * @dcd_cmds: List of DCD commands implemented by memory device
>   * @enabled_cmds: Hardware commands found enabled in CEL.
>   * @exclusive_cmds: Commands that are kernel-internal only
>   * @total_bytes: sum of all possible capacities
> @@ -460,6 +470,7 @@ struct cxl_memdev_state {
>  	size_t lsa_size;
>  	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
>  	char firmware_version[0x10];
> +	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
>  	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>  	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
>  	u64 total_bytes;
> @@ -525,6 +536,10 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_UNLOCK		=3D 0x4503,
>  	CXL_MBOX_OP_FREEZE_SECURITY	=3D 0x4504,
>  	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	=3D 0x4505,
> +	CXL_MBOX_OP_GET_DC_CONFIG	=3D 0x4800,
> +	CXL_MBOX_OP_GET_DC_EXTENT_LIST	=3D 0x4801,
> +	CXL_MBOX_OP_ADD_DC_RESPONSE	=3D 0x4802,
> +	CXL_MBOX_OP_RELEASE_DC		=3D 0x4803,
>  	CXL_MBOX_OP_MAX			=3D 0x10000
>  };
>
>
> --
> 2.41.0
>
