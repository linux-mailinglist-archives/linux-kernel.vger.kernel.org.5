Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FD8787550
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242561AbjHXQ0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242128AbjHXQ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:26:29 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E701BDB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:26:23 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so929427166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692894382; x=1693499182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jO6PdcGxXmw4FxGNaFews6qs3fzy4FgL27seXwidFd4=;
        b=MTH5rqiXdjnkANdudjixXhN5QodNwqjuoIa1zJ1wiq/CJ05UybHMYwAXiRtLGOxmZg
         awmMsdIb6R6glO+qHAGQWCmj0z8IxdJ0+Z3y5N/R+/8MniwihV41bJ2hvtDPHYC981ON
         7x7Moc0noBRVPobM4lR0kiWIOkyg7gKJMP6MZve9j8O8Cf4ZjitDNaC0Jllkqq3kSIrz
         +zm0Q/hhk9fIKGrdpXz3f/EEwWIaFUJlI7PMbGeVKKYVyqThnuEjprIardvUgGfw1Mv3
         eU8LpDjSweSrVIbMpgAfzfFNPefZGv3IB5kcmFXhp6EjUlpEAnk17T+qsPFRZXmfsNPG
         B9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692894382; x=1693499182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jO6PdcGxXmw4FxGNaFews6qs3fzy4FgL27seXwidFd4=;
        b=VAjM6CepW3dKzC+Kw5tzD2FTmMuK9JiPiwmvq8bM+I49AjB2XR+EzElodvpi0ypLhI
         MkgITxVP3p99Rhua5dd/eJdqyKvwSOCJE7driq4gQ0yRh6EWWUGDHIbG6t+Yg5vSFT85
         HSssaYhHcP389loXd1K73z8IB7kQKEPUw5/4LOC+bYwtciPb/kf0ctLAJMR/+qNVj0qI
         TF/voqR/yEW4++Q9O04tuJlOJhS3ZVP1CZk8yspxErbBt8YZVnJ1NYf6qVP6YfSVwHZB
         bVjzoPj085P1mtYEiH0uz+ujPAhwq8gJc5Res4Bz+pmXVPKPElO7cdPDTa1sGZKlyTtR
         I6SA==
X-Gm-Message-State: AOJu0YwDQi8DPN5j4ct0ykcI+QZ7SUfP7x7eysod+nWkCawe+FDegd18
        VP48Ejo0cx6Oj2QQQkd6wNsbMA==
X-Google-Smtp-Source: AGHT+IE2pauBeAOSc/R+1Rs7qq5wjkBhaQbBMC1qCWpSO0r0cc8yHnFk2TN5pvkeZepE//RxoH0zCg==
X-Received: by 2002:a17:906:112:b0:9a1:d67c:b4eb with SMTP id 18-20020a170906011200b009a1d67cb4ebmr4931498eje.48.1692894381609;
        Thu, 24 Aug 2023 09:26:21 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id k15-20020a17090666cf00b0099315454e76sm10955436ejp.211.2023.08.24.09.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 09:26:21 -0700 (PDT)
Message-ID: <4872bd8a-fac1-da34-f237-e6e26d56e843@linaro.org>
Date:   Thu, 24 Aug 2023 18:26:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] misc: bm92txx: Add driver for the ROHM BM92Txx
Content-Language: en-US
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     azkali <a.ffcc7@gmail.com>, Adam Jiang <chaoj@nvidia.com>,
        CTCaer <ctcaer@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230824153059.212244-1-linkmauve@linkmauve.fr>
 <20230824153059.212244-3-linkmauve@linkmauve.fr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230824153059.212244-3-linkmauve@linkmauve.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 17:30, Emmanuel Gil Peyrot wrote:
> From: azkali <a.ffcc7@gmail.com>
> 
> This is used as the USB-C Power Delivery controller of the Nintendo
> Switch.
> 
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> Signed-off-by: azkali <a.ffcc7@gmail.com>
> Signed-off-by: Adam Jiang <chaoj@nvidia.com>
> Signed-off-by: CTCaer <ctcaer@gmail.com>
> ---

...

	dev_err(dev, "Device in UFP and DRD not supported!\n");
> +					break;
> +				}
> +
> +				cmd = DR_SWAP_CMD;
> +				err = bm92t_send_cmd(info, &cmd);
> +				bm92t_state_machine(info, DR_SWAP_SENT);
> +			} else if (bm92t_is_dfp(status1_data)) {
> +				dev_dbg(dev, "Already in DFP mode\n");
> +				bm92t_send_vdm(info, vdm_discover_id_msg,
> +					sizeof(vdm_discover_id_msg));
> +				bm92t_state_machine(info, VDM_DISC_ID_SENT);
> +			}
> +		}
> +		break;
> +
> +	case DR_SWAP_SENT:
> +		if ((bm92t_is_success(alert_data) &&
> +			 bm92t_is_plugged(status1_data) &&
> +			 bm92t_is_lastcmd_ok(info, "DR_SWAP_CMD", status1_data) &&
> +			 bm92t_is_dfp(status1_data))) {

Some misalignments here... Actually all over the code. This looks like
some vendor stuff being upstreamed without proper rework/cleaning.

> +			bm92t_send_vdm(info, vdm_discover_id_msg,
> +				sizeof(vdm_discover_id_msg));
> +			bm92t_state_machine(info, VDM_DISC_ID_SENT);
> +		}
> +		break;
> +
> +	case VDM_DISC_ID_SENT:
> +		if (bm92t_received_vdm(alert_data)) {
> +			cmd = ACCEPT_VDM_CMD;
> +			err = bm92t_send_cmd(info, &cmd);
> +			bm92t_state_machine(info, VDM_ACCEPT_DISC_ID_REPLY);
> +		} else if (bm92t_is_success(alert_data))
> +			dev_dbg(dev, "cmd done in VDM_DISC_ID_SENT\n");
> +		break;
> +
> +	case VDM_ACCEPT_DISC_ID_REPLY:
> +		if (bm92t_is_success(alert_data)) {
> +			/* Check incoming VDM */
> +			err = bm92t_read_reg(info, INCOMING_VDM_REG,
> +				vdm, sizeof(vdm));
> +
> +			memcpy(&info->cable.vdo, &vdm[5], sizeof(struct vd_object));
> +
> +			bm92t_print_dp_dev_info(dev, &info->cable.vdo);
> +
> +			/* Check if Nintendo dock. */
> +			if (!(info->cable.vdo.type == VDO_ID_TYPE_ALTERNATE &&
> +				  info->cable.vdo.vid == VID_NINTENDO &&
> +				  info->cable.vdo.pid == PID_NIN_DOCK)) {
> +				dev_err(dev, "VID/PID not Nintendo Dock\n");
> +				bm92t_send_vdm(info, vdm_discover_svid_msg,
> +					sizeof(vdm_discover_svid_msg));
> +				bm92t_state_machine(info, VDM_DISC_SVID_SENT);
> +			} else {
> +				info->cable.is_nintendo_dock = true;
> +				bm92t_send_vdm(info, vdm_enter_nin_alt_mode_msg,
> +					sizeof(vdm_enter_nin_alt_mode_msg));
> +				bm92t_state_machine(info, VDM_ENTER_ND_ALT_MODE_SENT);
> +			}
> +		}
> +		break;
> +
> +	case VDM_DISC_SVID_SENT:
> +		if (bm92t_received_vdm(alert_data)) {
> +			cmd = ACCEPT_VDM_CMD;
> +			err = bm92t_send_cmd(info, &cmd);
> +			bm92t_state_machine(info, VDM_ACCEPT_DISC_SVID_REPLY);
> +		} else if (bm92t_is_success(alert_data))
> +			dev_dbg(dev, "cmd done in VDM_DISC_SVID_SENT\n");
> +		break;
> +
> +	case VDM_ACCEPT_DISC_SVID_REPLY:
> +		if (bm92t_is_success(alert_data)) {
> +			/* Check discovered SVIDs */
> +			err = bm92t_read_reg(info, INCOMING_VDM_REG, vdm, sizeof(vdm));
> +
> +			if (vdm[1] == (VDM_ACK | VDM_CMD_DISC_SVID)) {
> +				dev_info(dev, "Supported SVIDs:\n");
> +				for (i = 0; i < ((vdm[0] - 4) / 2); i++)
> +					dev_info(dev, "SVID%d %04X\n",
> +						i, vdm[5 + i * 2] | (vdm[6 + i * 2] << 8));
> +
> +				/* Request DisplayPort Alt mode support SVID (0xFF01) */
> +				bm92t_send_vdm(info, vdm_discover_mode_msg,
> +					sizeof(vdm_discover_mode_msg));
> +				bm92t_state_machine(info, VDM_DISC_MODE_SENT);
> +			}
> +		}
> +		break;
> +
> +	case VDM_DISC_MODE_SENT:
> +		if (bm92t_received_vdm(alert_data)) {
> +			cmd = ACCEPT_VDM_CMD;
> +			err = bm92t_send_cmd(info, &cmd);
> +			bm92t_state_machine(info, VDM_ACCEPT_DISC_MODE_REPLY);
> +		} else if (bm92t_is_success(alert_data))
> +			dev_dbg(dev, "cmd done in VDM_DISC_MODE_SENT\n");
> +		break;
> +
> +	case VDM_ACCEPT_DISC_MODE_REPLY:
> +		if (bm92t_is_success(alert_data)) {
> +			/* Check incoming VDM */
> +			err = bm92t_read_reg(info, INCOMING_VDM_REG, vdm, sizeof(vdm));
> +
> +			/* Check if DisplayPort Alt mode is supported */
> +			if (vdm[0] > 4 && /* Has VDO objects */
> +					vdm[1] == (VDM_ACK | VDM_CMD_DISC_MODE) &&
> +					vdm[2] == VDM_STRUCTURED &&
> +					vdm[3] == 0x01 && vdm[4] == 0xFF && /* SVID DisplayPort */
> +					vdm[5] & VDO_DP_UFP_D &&
> +					vdm[5] & VDO_DP_SUPPORT) {
> +				dev_info(dev, "DisplayPort Alt Mode supported");
> +				for (i = 0; i < ((vdm[0] - 4) / 4); i++)
> +					dev_info(dev, "DPCap%d %08X\n",
> +						i, vdm[5 + i * 4] | (vdm[6 + i * 4] << 8) |
> +						(vdm[7 + i * 4] << 16) | (vdm[8 + i * 4] << 24));
> +
> +				/* Enter automatic DisplayPort handling */
> +				cmd = DP_ENTER_MODE_CMD;
> +				err = bm92t_send_cmd(info, &cmd);
> +				msleep(100); /* WAR: may not need to wait */
> +				bm92t_state_machine(info, DP_DISCOVER_MODE);
> +			}
> +		}
> +		break;
> +
> +	case VDM_ENTER_ND_ALT_MODE_SENT:
> +		if (bm92t_received_vdm(alert_data)) {
> +			cmd = ACCEPT_VDM_CMD;
> +			err = bm92t_send_cmd(info, &cmd);
> +			bm92t_state_machine(info, VDM_ACCEPT_ENTER_NIN_ALT_MODE_REPLY);
> +		} else if (bm92t_is_success(alert_data))
> +			dev_dbg(dev, "cmd done in VDM_ENTER_ND_ALT_MODE_SENT\n");
> +		break;
> +
> +	case VDM_ACCEPT_ENTER_NIN_ALT_MODE_REPLY:
> +		if (bm92t_is_success(alert_data)) {
> +			/* Check incoming VDM */
> +			err = bm92t_read_reg(info, INCOMING_VDM_REG, vdm, sizeof(vdm));
> +
> +			/* Check if supported. */
> +			if (!(vdm[1] == (VDM_ACK | VDM_CMD_ENTER_MODE) &&
> +				vdm[2] == (VDM_STRUCTURED | 1) &&
> +				vdm[3] == 0x7e && vdm[4] == 0x05)) {
> +				dev_err(dev, "Failed to enter Nintendo Alt Mode!\n");
> +				break;
> +			}
> +
> +			/* Enter automatic DisplayPort handling */
> +			cmd = DP_ENTER_MODE_CMD;
> +			err = bm92t_send_cmd(info, &cmd);
> +			msleep(100); /* WAR: may not need to wait */
> +			bm92t_state_machine(info, DP_DISCOVER_MODE);
> +		}
> +		break;
> +
> +	case DP_DISCOVER_MODE:
> +		if (bm92t_is_success(alert_data)) {
> +			err = bm92t_handle_dp_config_and_hpd(info);
> +			if (!err)
> +				bm92t_state_machine(info, DP_CFG_START_HPD_SENT);
> +			else
> +				bm92t_state_machine(info, INIT_STATE);
> +		}
> +		break;
> +
> +	case DP_CFG_START_HPD_SENT:
> +		if (bm92t_is_success(alert_data)) {
> +			if (bm92t_is_plugged(status1_data) &&
> +				bm92t_is_lastcmd_ok(info, "DP_CFG_AND_START_HPD_CMD",
> +					status1_data)) {
> +				if (info->cable.is_nintendo_dock) {
> +					bm92t_send_vdm(info, vdm_query_device_msg,
> +						sizeof(vdm_query_device_msg));
> +					bm92t_state_machine(info, VDM_ND_QUERY_DEVICE_SENT);
> +				} else
> +					bm92t_state_machine(info, NORMAL_CONFIG_HANDLED);
> +			}
> +		}
> +		break;
> +
> +	/* Nintendo Dock VDMs */
> +	case VDM_ND_QUERY_DEVICE_SENT:
> +		if (bm92t_received_vdm(alert_data)) {
> +			cmd = ACCEPT_VDM_CMD;
> +			err = bm92t_send_cmd(info, &cmd);
> +			bm92t_state_machine(info, VDM_ACCEPT_ND_QUERY_DEVICE_REPLY);
> +		} else if (bm92t_is_success(alert_data))
> +			dev_dbg(dev, "cmd done in VDM_ND_QUERY_DEVICE_SENT\n");
> +		break;
> +
> +	case VDM_ACCEPT_ND_QUERY_DEVICE_REPLY:
> +		if (bm92t_is_success(alert_data)) {
> +			/* Check incoming VDM */
> +			err = bm92t_read_reg(info, INCOMING_VDM_REG, vdm, sizeof(vdm));
> +
> +			if (!err && vdm[6] == VDM_ND_DOCK &&
> +				 vdm[7] == (VDM_NCMD_DEVICE_STATE + 1)) {
> +				/* Check if USB HUB is supported */
> +				if (vdm[11] & 0x02) {
> +					bm92t_extcon_cable_update(info, EXTCON_USB_HOST, false);
> +					msleep(500);
> +					bm92t_extcon_cable_update(info, EXTCON_USB, true);
> +					dev_err(dev, "Dock has old FW!\n");
> +				}
> +				dev_info(dev, "device state: %02X %02X %02X %02X\n",
> +					 vdm[9], vdm[10], vdm[11], vdm[12]);
> +			} else
> +				dev_err(dev, "Failed to get dock state reply!");
> +
> +			/* Set dock LED */
> +			bm92t_usbhub_led_cfg(info, 128, 0, 0, 64);
> +			bm92t_state_machine(info, VDM_ND_LED_ON_SENT);
> +		}
> +		break;
> +
> +	case VDM_ND_LED_ON_SENT:
> +		if (bm92t_received_vdm(alert_data)) {
> +			cmd = ACCEPT_VDM_CMD;
> +			err = bm92t_send_cmd(info, &cmd);
> +			bm92t_state_machine(info, VDM_ACCEPT_ND_LED_ON_REPLY);
> +		} else if (bm92t_is_success(alert_data))
> +			dev_dbg(dev, "cmd done in VDM_ND_LED_ON_SENT\n");
> +		break;
> +
> +	case VDM_ACCEPT_ND_LED_ON_REPLY:
> +		if (bm92t_is_success(alert_data)) {
> +			msleep(500); /* Wait for hub to power up */
> +			bm92t_send_vdm(info, vdm_usbhub_enable_msg, sizeof(vdm_usbhub_enable_msg));
> +			bm92t_state_machine(info, VDM_ND_ENABLE_USBHUB_SENT);
> +		}
> +		break;
> +
> +	case VDM_ND_ENABLE_USBHUB_SENT:
> +		if (bm92t_received_vdm(alert_data)) {
> +			cmd = ACCEPT_VDM_CMD;
> +			err = bm92t_send_cmd(info, &cmd);
> +			bm92t_state_machine(info, VDM_ACCEPT_ND_ENABLE_USBHUB_REPLY);
> +		} else if (bm92t_is_success(alert_data))
> +			dev_dbg(dev, "cmd done in VDM_ND_ENABLE_USBHUB_SENT\n");
> +		break;
> +
> +	case VDM_ACCEPT_ND_ENABLE_USBHUB_REPLY:
> +		if (bm92t_is_success(alert_data)) {
> +			/* Check incoming VDM */
> +			err = bm92t_read_reg(info, INCOMING_VDM_REG, vdm, sizeof(vdm));
> +
> +			if ((vdm[6] == VDM_ND_DOCK &&
> +				 vdm[7] == (VDM_NCMD_HUB_CONTROL + 1) &&
> +				 retries_usbhub)) {
> +				if (vdm[5] & VDM_ND_BUSY) {
> +					msleep(250);
> +					dev_info(dev, "Retrying USB HUB enable...\n");
> +					bm92t_send_vdm(info, vdm_usbhub_enable_msg,
> +						       sizeof(vdm_usbhub_enable_msg));
> +					bm92t_state_machine(info, VDM_ND_ENABLE_USBHUB_SENT);
> +					retries_usbhub--;
> +					break;
> +				}
> +			} else if (!retries_usbhub)
> +				dev_err(dev, "USB HUB enable timed out!\n");
> +			else
> +				dev_err(dev, "USB HUB enable failed!\n");
> +
> +			bm92t_state_machine(info, NINTENDO_CONFIG_HANDLED);
> +		}
> +		break;
> +
> +	case VDM_ND_CUSTOM_CMD_SENT:
> +		if (bm92t_received_vdm(alert_data)) {
> +			cmd = ACCEPT_VDM_CMD;
> +			err = bm92t_send_cmd(info, &cmd);
> +			bm92t_state_machine(info, VDM_ACCEPT_ND_CUSTOM_CMD_REPLY);
> +		} else if (bm92t_is_success(alert_data))
> +			dev_dbg(dev, "cmd done in VDM_ND_CUSTOM_CMD_SENT\n");
> +		break;
> +
> +	case VDM_ACCEPT_ND_CUSTOM_CMD_REPLY:
> +		if (bm92t_is_success(alert_data)) {
> +			/* Read incoming VDM */
> +			err = bm92t_read_reg(info, INCOMING_VDM_REG, vdm, sizeof(vdm));
> +			bm92t_state_machine(info, NINTENDO_CONFIG_HANDLED);
> +		}
> +		break;
> +	/* End of Nintendo Dock VDMs */
> +
> +	case VDM_CUSTOM_CMD_SENT:
> +		if (bm92t_received_vdm(alert_data)) {
> +			cmd = ACCEPT_VDM_CMD;
> +			err = bm92t_send_cmd(info, &cmd);
> +			bm92t_state_machine(info, VDM_ACCEPT_CUSTOM_CMD_REPLY);
> +		} else if (bm92t_is_success(alert_data))
> +			dev_dbg(dev, "cmd done in VDM_CUSTOM_CMD_SENT\n");
> +		break;
> +
> +	case VDM_ACCEPT_CUSTOM_CMD_REPLY:
> +		if (bm92t_is_success(alert_data)) {
> +			/* Read incoming VDM */
> +			err = bm92t_read_reg(info, INCOMING_VDM_REG, vdm, sizeof(vdm));
> +			bm92t_state_machine(info, NORMAL_CONFIG_HANDLED);
> +		}
> +		break;
> +
> +	case NORMAL_CONFIG_HANDLED:
> +	case NINTENDO_CONFIG_HANDLED:
> +		break;
> +
> +	default:
> +		dev_err(dev, "Invalid state!\n");
> +		break;
> +	}
> +
> +ret:
> +	enable_irq(info->i2c_client->irq);

Why do you enable IRQ in a handler? This is odd.

> +}
> +
> +static irqreturn_t bm92t_interrupt_handler(int irq, void *handle)
> +{
> +	struct bm92t_info *info = handle;
> +
> +	disable_irq_nosync(info->i2c_client->irq);

Wait, no, why do you do it?

> +	queue_work(info->event_wq, &info->work);
> +	return IRQ_HANDLED;
> +}

You do not have any interrupts on these chips (at least this is what you
said in the binding).

> +
> +static void bm92t_remove(struct i2c_client *client)
> +{
> +	struct bm92t_info *info = i2c_get_clientdata(client);
> +
> +#ifdef CONFIG_DEBUG_FS
> +	debugfs_remove_recursive(info->debugfs_root);
> +#endif

Remove() is after probe().

> +}
> +
> +static void bm92t_shutdown(struct i2c_client *client)
> +{
> +	struct bm92t_info *info = i2c_get_clientdata(client);
> +
> +	/* Disable Dock LED if enabled */
> +	bm92t_usbhub_led_cfg_wait(info, 0, 0, 0, 128);
> +
> +	/* Disable SPDSRC */
> +	bm92t_set_source_mode(info, SPDSRC12_OFF);
> +
> +	/* Disable DisplayPort Alerts */
> +	if (info->pdata->dp_alerts_enable)
> +		bm92t_set_dp_alerts(info, false);

Why do you need shutdown callback?

It should be placed after remove() one, anyway.

> +}
> +
> +#ifdef CONFIG_DEBUG_FS
> +static int bm92t_regs_print(struct seq_file *s, const char *reg_name,
> +	unsigned char reg_addr, int size)
> +{
> +	int err;
> +	unsigned char msg[5];
> +	unsigned short reg_val16;
> +	unsigned short reg_val32;
> +	struct bm92t_info *info = (struct bm92t_info *) (s->private);
> +
> +	switch (size) {
> +	case 2:
> +		err = bm92t_read_reg(info, reg_addr,
> +			    (unsigned char *) &reg_val16, sizeof(reg_val16));
> +		if (!err)
> +			seq_printf(s, "%s 0x%04X\n", reg_name, reg_val16);
> +		break;
> +	case 4:
> +		err = bm92t_read_reg(info, reg_addr,
> +			    (unsigned char *) &reg_val32, sizeof(reg_val32));
> +		if (!err)
> +			seq_printf(s, "%s 0x%08X\n", reg_name, reg_val32);
> +		break;
> +	case 5:
> +		err = bm92t_read_reg(info, reg_addr, msg, sizeof(msg));
> +		if (!err)
> +			seq_printf(s, "%s 0x%02X%02X%02X%02X\n",
> +				reg_name, msg[4], msg[3], msg[2], msg[1]);
> +		break;
> +	default:
> +		err = -EINVAL;
> +		break;
> +	}
> +
> +	if (err)
> +		dev_err(&info->i2c_client->dev, "Cannot read 0x%02X\n", reg_addr);
> +
> +	return err;
> +}
> +
> +static int bm92t_regs_show(struct seq_file *s, void *data)
> +{
> +	int err;
> +
> +	err = bm92t_regs_print(s, "ALERT_STATUS:  ", ALERT_STATUS_REG, 2);
> +	if (err)
> +		return err;
> +	err = bm92t_regs_print(s, "STATUS1:       ", STATUS1_REG, 2);
> +	if (err)
> +		return err;
> +	err = bm92t_regs_print(s, "STATUS2:       ", STATUS2_REG, 2);
> +	if (err)
> +		return err;
> +	err = bm92t_regs_print(s, "DP_STATUS:     ", DP_STATUS_REG, 2);
> +	if (err)
> +		return err;
> +	err = bm92t_regs_print(s, "CONFIG1:       ", CONFIG1_REG, 2);
> +	if (err)
> +		return err;
> +	err = bm92t_regs_print(s, "CONFIG2:       ", CONFIG2_REG, 2);
> +	if (err)
> +		return err;
> +	err = bm92t_regs_print(s, "SYS_CONFIG1:   ", SYS_CONFIG1_REG, 2);
> +	if (err)
> +		return err;
> +	err = bm92t_regs_print(s, "SYS_CONFIG2:   ", SYS_CONFIG2_REG, 2);
> +	if (err)
> +		return err;
> +	err = bm92t_regs_print(s, "SYS_CONFIG3:   ", SYS_CONFIG3_REG, 2);
> +	if (err)
> +		return err;
> +	err = bm92t_regs_print(s, "VENDOR_CONFIG: ", VENDOR_CONFIG_REG, 2);
> +	if (err)
> +		return err;
> +	err = bm92t_regs_print(s, "DEV_CAPS:      ", DEV_CAPS_REG, 2);
> +	if (err)
> +		return err;
> +	err = bm92t_regs_print(s, "ALERT_ENABLE:  ", ALERT_ENABLE_REG, 4);
> +	if (err)
> +		return err;
> +	err = bm92t_regs_print(s, "DP_ALERT_EN:   ", DP_ALERT_EN_REG, 2);
> +	if (err)
> +		return err;
> +	err = bm92t_regs_print(s, "AUTO_NGT_FIXED:", AUTO_NGT_FIXED_REG, 5);
> +	if (err)
> +		return err;
> +	err = bm92t_regs_print(s, "AUTO_NGT_BATT: ", AUTO_NGT_BATT_REG, 5);
> +	if (err)
> +		return err;
> +	err = bm92t_regs_print(s, "CURRENT_PDO:   ", CURRENT_PDO_REG, 5);
> +	if (err)
> +		return err;
> +	err = bm92t_regs_print(s, "CURRENT_RDO:   ", CURRENT_RDO_REG, 5);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int bm92t_regs_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, bm92t_regs_show, inode->i_private);
> +}
> +
> +static const struct file_operations bm92t_regs_fops = {
> +	.open = bm92t_regs_open,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +};
> +
> +static int bm92t_state_show(struct seq_file *s, void *data)
> +{
> +	struct bm92t_info *info = (struct bm92t_info *) (s->private);
> +
> +	seq_printf(s, "%s\n", states[info->state]);
> +	return 0;
> +}
> +static int bm92t_state_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, bm92t_state_show, inode->i_private);
> +}
> +
> +static const struct file_operations bm92t_state_fops = {
> +	.open = bm92t_state_open,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +};
> +
> +static int bm92t_fw_info_show(struct seq_file *s, void *data)
> +{
> +	struct bm92t_info *info = (struct bm92t_info *) (s->private);
> +
> +	seq_printf(s, "fw_type: 0x%02X, fw_revision: 0x%02X\n", info->fw_type, info->fw_revision);
> +	return 0;
> +}
> +static int bm92t_fw_info_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, bm92t_fw_info_show, inode->i_private);
> +}
> +
> +static const struct file_operations bm92t_fwinfo_fops = {
> +	.open = bm92t_fw_info_open,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +};
> +
> +static ssize_t bm92t_led_write(struct file *file,
> +		     const char __user *userbuf, size_t count, loff_t *ppos)
> +{
> +	struct bm92t_info *info = (struct bm92t_info *) (file->private_data);
> +	unsigned int duty, time_on, time_off, fade;
> +	char buf[32];
> +	int ret;
> +
> +	count = min_t(size_t, count, (sizeof(buf)-1));
> +	if (copy_from_user(buf, userbuf, count))
> +		return -EFAULT;
> +
> +	buf[count] = 0;
> +
> +	ret = sscanf(buf, "%i %i %i %i",
> +		&duty, &time_on, &time_off, &fade);
> +
> +	if (ret == 4) {
> +		if (info->state == VDM_ACCEPT_ND_ENABLE_USBHUB_REPLY ||
> +		    info->state == NINTENDO_CONFIG_HANDLED) {
> +			bm92t_state_machine(info, VDM_ND_CUSTOM_CMD_SENT);
> +			bm92t_usbhub_led_cfg(info, duty, time_on, time_off, fade);
> +		} else
> +			dev_err(&info->i2c_client->dev, "LED is not supported\n");
> +	} else {
> +		dev_err(&info->i2c_client->dev, "LED syntax is: duty time_on time_off fade\n");
> +		return -EINVAL;

No, LEDs are done via led class, not via debugfs. Drop entire LED
handling this way and use led class.

> +	}
> +
> +	return count;
> +}
> +
> +static const struct file_operations bm92t_led_fops = {
> +	.open = simple_open,
> +	.write = bm92t_led_write,
> +};
> +
> +static ssize_t bm92t_cmd_write(struct file *file,
> +		     const char __user *userbuf, size_t count, loff_t *ppos)
> +{
> +	struct bm92t_info *info = (struct bm92t_info *) (file->private_data);
> +	unsigned short cmd;
> +	char buf[8];
> +	int ret;
> +
> +	count = min_t(size_t, count, (sizeof(buf)-1));
> +	if (copy_from_user(buf, userbuf, count))
> +		return -EFAULT;
> +
> +	buf[count] = 0;
> +
> +	ret = kstrtou16(buf, 0, &cmd);
> +
> +	if (ret != 0) {
> +		return -EINVAL;
> +
> +	bm92t_send_cmd(info, &cmd);

What are these commands? What interface do you cerate here?

> +
> +	return count;
> +}
> +
> +static const struct file_operations bm92t_cmd_fops = {
> +	.open = simple_open,
> +	.write = bm92t_cmd_write,
> +};
> +
> +static ssize_t bm92t_usbhub_dp_sleep_write(struct file *file,
> +		     const char __user *userbuf, size_t count, loff_t *ppos)
> +{
> +	struct bm92t_info *info = (struct bm92t_info *) (file->private_data);
> +	unsigned int val;
> +	char buf[8];
> +	int ret;
> +
> +	count = min_t(size_t, count, (sizeof(buf)-1));
> +	if (copy_from_user(buf, userbuf, count))
> +		return -EFAULT;
> +
> +	buf[count] = 0;
> +
> +	ret = kstrtouint(buf, 0, &val);
> +
> +	if (ret != 0)
> +		return -EINVAL;
> +
> +	bm92t_usbhub_dp_sleep(info, val ? true : false);

Why do you have interface for sleeping with debugfs? This does not look
anymore as debugging interface.

> +
> +	return count;
> +}
> +
> +static const struct file_operations bm92t_usbhub_dp_sleep_fops = {
> +	.open = simple_open,
> +	.write = bm92t_usbhub_dp_sleep_write,
> +};
> +
> +static int bm92t_debug_init(struct bm92t_info *info)
> +{
> +	info->debugfs_root = debugfs_create_dir("bm92txx", NULL);
> +	if (!info->debugfs_root)
> +		goto failed;
> +
> +	if (!debugfs_create_file("regs", 0400,
> +				 info->debugfs_root,
> +				 info,
> +				 &bm92t_regs_fops))
> +		goto failed;
> +
> +	if (!debugfs_create_file("state", 0400,
> +				 info->debugfs_root,
> +				 info,
> +				 &bm92t_state_fops))
> +		goto failed;
> +
> +	if (!debugfs_create_file("fw_info", 0400,
> +				 info->debugfs_root,
> +				 info,
> +				 &bm92t_fwinfo_fops))
> +		goto failed;
> +
> +	if (!debugfs_create_file("led", 0200,
> +				 info->debugfs_root,
> +				 info,
> +				 &bm92t_led_fops))
> +		goto failed;
> +
> +	if (!debugfs_create_file("cmd", 0200,
> +				 info->debugfs_root,
> +				 info,
> +				 &bm92t_cmd_fops))
> +		goto failed;
> +
> +	if (!debugfs_create_file("sleep", 0200,
> +				 info->debugfs_root,
> +				 info,
> +				 &bm92t_usbhub_dp_sleep_fops))
> +		goto failed;
> +
> +	return 0;
> +
> +failed:
> +	dev_err(&info->i2c_client->dev, "%s: failed\n", __func__);

Drop err message.


> +	debugfs_remove_recursive(info->debugfs_root);
> +	return -ENOMEM;
> +}
> +#endif

...

> +static int bm92t_probe(struct i2c_client *client)
> +{
> +	struct bm92t_info *info;
> +	struct regulator *batt_chg_reg;
> +	struct regulator *vbus_reg;
> +	struct fwnode_handle *ep, *remote;
> +	int err;
> +	unsigned short reg_value;
> +
> +	/* Get battery charger and VBUS regulators */
> +	batt_chg_reg = devm_regulator_get(&client->dev, "pd_bat_chg");
> +	if (IS_ERR(batt_chg_reg)) {
> +		err = PTR_ERR(batt_chg_reg);
> +		if (err == -EPROBE_DEFER)
> +			return err;
> +
> +		dev_err(&client->dev, "pd_bat_chg reg not registered: %d\n", err);
> +		batt_chg_reg = NULL;

The syntax is return dev_err_probe(). Do not open-code it.

> +	}
> +
> +	vbus_reg = devm_regulator_get(&client->dev, "vbus");
> +	if (IS_ERR(vbus_reg)) {
> +		err = PTR_ERR(vbus_reg);
> +		if (err == -EPROBE_DEFER)
> +			return err;
> +
> +		dev_err(&client->dev, "vbus reg not registered: %d\n", err);
> +		vbus_reg = NULL;
> +	}
> +
> +	info = devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	if (client->dev.of_node) {
> +		info->pdata = bm92t_parse_dt(&client->dev);
> +		if (IS_ERR(info->pdata))
> +			return PTR_ERR(info->pdata);
> +	} else {
> +		info->pdata = client->dev.platform_data;
> +		if (!info->pdata) {
> +			dev_err(&client->dev, "no platform data provided\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(&client->dev), 0, 0, 0);

Your bindings do not allow this code.

> +	if (!ep) {
> +		dev_err(&client->dev, "Endpoint not found\n");
> +		return -ENODEV;
> +	}
> +
> +	remote = fwnode_graph_get_remote_endpoint(ep);
> +	if (!remote) {
> +		dev_err(&client->dev, "Remote not found\n");
> +		return -ENODEV;
> +	}
> +
> +	info->role_sw = fwnode_usb_role_switch_get(remote);

This as well, I think.

> +	if (IS_ERR_OR_NULL(info->role_sw)) {
> +		err = PTR_ERR(info->role_sw);
> +		dev_err(&client->dev, "Failed to retrieve fwnode: %d\n", err);
> +		return err;
> +	}
> +
> +	i2c_set_clientdata(client, info);
> +
> +	info->i2c_client = client;
> +
> +	info->batt_chg_reg = batt_chg_reg;
> +	info->vbus_reg = vbus_reg;
> +
> +	/* Initialized state */
> +	info->state = INIT_STATE;
> +	info->first_init = true;
> +
> +	/* Allocate extcon */
> +	info->edev = devm_extcon_dev_allocate(&client->dev, bm92t_extcon_cable);
> +	if (IS_ERR(info->edev))
> +		return -ENOMEM;
> +
> +	/* Register extcon */
> +	err = devm_extcon_dev_register(&client->dev, info->edev);
> +	if (err < 0) {
> +		dev_err(&client->dev, "Cannot register extcon device\n");
> +		return err;
> +	}
> +
> +	/* Create workqueue */
> +	info->event_wq = create_singlethread_workqueue("bm92t-event-queue");
> +	if (!info->event_wq) {
> +		dev_err(&client->dev, "Cannot create work queue\n");
> +		return -ENOMEM;
> +	}
> +
> +	err = bm92t_read_reg(info, FW_TYPE_REG, (unsigned char *) &reg_value, sizeof(reg_value));

Does not look like wrapped at 80. See coding style.

> +	info->fw_type = reg_value;
> +
> +	err = bm92t_read_reg(info, FW_REVISION_REG, (unsigned char *) &reg_value,
> +			     sizeof(reg_value));
> +	info->fw_revision = reg_value;
> +
> +	dev_info(&info->i2c_client->dev, "fw_type: 0x%02X, fw_revision: 0x%02X\n", info->fw_type,
> +		 info->fw_revision);
> +
> +	if (info->fw_revision <= 0x644)
> +		return -EINVAL;
> +
> +	/* Disable Source mode at boot */
> +	bm92t_set_source_mode(info, SPDSRC12_OFF);
> +
> +	INIT_WORK(&info->work, bm92t_event_handler);
> +	INIT_DELAYED_WORK(&info->oneshot_work, bm92t_extcon_cable_set_init_state);
> +
> +	INIT_DELAYED_WORK(&info->power_work, bm92t_power_work);
> +
> +	if (client->irq > 0) {

You do not have interrupts. Either you submitted really incomplete
binding or this code is some dead code copied from somwhere.

> +		if (request_irq(client->irq, bm92t_interrupt_handler, IRQF_TRIGGER_LOW, "bm92t",
> +				info)) {
> +			dev_err(&client->dev, "Request irq failed\n");
> +			destroy_workqueue(info->event_wq);
> +			return -EBUSY;
> +		}
> +	}
> +
> +	schedule_delayed_work(&info->oneshot_work, msecs_to_jiffies(5000));
> +
> +#ifdef CONFIG_DEBUG_FS
> +	bm92t_debug_init(info);
> +#endif
> +
> +	dev_info(&client->dev, "bm92txx driver loading done\n");

Drop such traicing infos. All of them.

> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int bm92t_pm_suspend(struct device *dev)
> +{
> +	struct bm92t_info *info = dev_get_drvdata(dev);
> +	struct i2c_client *client = info->i2c_client;
> +
> +	/* Dim or breathing Dock LED */
> +	if (info->pdata->led_static_on_suspend)
> +		bm92t_usbhub_led_cfg_wait(info, 16, 0, 0, 128);
> +	else
> +		bm92t_usbhub_led_cfg_wait(info, 32, 1, 255, 255);
> +
> +	if (client->irq > 0) {
> +		disable_irq(client->irq);
> +		enable_irq_wake(client->irq);
> +	}
> +
> +	return 0;
> +}
> +
> +static int bm92t_pm_resume(struct device *dev)
> +{
> +	struct bm92t_info *info = dev_get_drvdata(dev);
> +	struct i2c_client *client = info->i2c_client;
> +	bool enable_led = info->state == NINTENDO_CONFIG_HANDLED;
> +
> +	if (client->irq > 0) {
> +		enable_irq(client->irq);
> +		disable_irq_wake(client->irq);
> +	}
> +
> +	/*
> +	 * Toggle DP signal
> +	 * Do a toggle on resume instead of disable in suspend
> +	 * and enable in resume, because this also disables the
> +	 * led effects.
> +	 */
> +	if (info->pdata->dp_signal_toggle_on_resume) {
> +		bm92t_usbhub_dp_sleep(info, true);
> +		bm92t_usbhub_dp_sleep(info, false);
> +	}
> +
> +	/* Set Dock LED to ON state */
> +	if (enable_led)
> +		bm92t_usbhub_led_cfg_wait(info, 128, 0, 0, 64);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops bm92t_pm_ops = {
> +	.suspend = bm92t_pm_suspend,
> +	.resume = bm92t_pm_resume,
> +};
> +#endif
> +
> +static const struct i2c_device_id bm92t_id[] = {
> +	{ "bm92t", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, bm92t_id);
> +
> +static struct i2c_driver bm92t_i2c_driver = {
> +	.driver = {
> +		.name = "bm92t",
> +		.owner = THIS_MODULE,
> +		.of_match_table = bm92t_of_match,
> +#ifdef CONFIG_PM
> +		.pm = &bm92t_pm_ops,
> +#endif
> +	},
> +	.id_table = bm92t_id,
> +	.probe = bm92t_probe,
> +	.remove = bm92t_remove,
> +	.shutdown = bm92t_shutdown,
> +};
> +
> +static int __init bm92t_init(void)
> +{
> +	return i2c_add_driver(&bm92t_i2c_driver);
> +}
> +subsys_initcall_sync(bm92t_init);

No, you do not get a subsys initcall. This is a driver. Use module
wrapper for init and exit.


Best regards,
Krzysztof

