Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A707B5BEC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 22:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjJBUXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 16:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjJBUXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 16:23:07 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF995B7;
        Mon,  2 Oct 2023 13:23:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-406609df1a6so1755745e9.3;
        Mon, 02 Oct 2023 13:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696278182; x=1696882982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P3DQ226AVtI3ls9uibMswZK6zu1JJhED9CPMNiHdPPw=;
        b=GcN6E+HQ44mUYM0QAMaeDSUYnVOfbHbESNk5cJQgUZtyCcsErtQK09LHGnRcZ3uSCE
         21Q3jx93kFi0HZLdlnS8xSfEPbFMqBrCvDJ5Ekhm6vQg2Pcb66WGcC1Ke4Bd7DO3j+7o
         gKEXhJQLwWSLfIqls6j2wxR/xoXkCQjU3KJDqEFqlXQx/iK7/4+pzz7hohzNhYKm0o3q
         95oFa66doKHxD8FerKZ1uwoUuIs4U5clrmtv/Pay+UNAUrnuiCPMXJTig3rzfgAzeXjd
         QwcK5z+Aj8LeA8ikslSN4Oz/k35vtfzgVUvxJGXMrPqErwd5SPYNBV3PEeMQo9ZPZA9U
         Tm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696278182; x=1696882982;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3DQ226AVtI3ls9uibMswZK6zu1JJhED9CPMNiHdPPw=;
        b=ALTXXPFWKZ3GQ5Oi7l9CORmjuSIb/wvi9SvPuXTbGR8LEUFXhy1QZ/i/LPPREw5LdG
         Q0ZgcybfQlq0JoR+fw06bDbBzmTFqZTUUvEG5tFPMODWWSyFRo2O0CMRhhBeXifORFwz
         0flp7bbQtKLORfl1u6iBsUUwd+71otf/kFR7gGrFhodx0gbEQ3vJcAOdtyPILTS7uFb+
         8qYAYo/ctHOGtcCyaiK/8AqgICFUnBV8tvnRDmWOe8TRqeDOrVso2N3RkCzSn63cll9q
         n2F06CdSDelq9Du5IxTJBOH+6jj75nxS0Khqf/FTD51GZmUpOB/H6pyi41KPT1XkB2vx
         OcsQ==
X-Gm-Message-State: AOJu0YxeauYHzqYxJEscP29B3g3dPJBtZhHGFNlMCuT6/7zWMXwJmrHT
        fzyQ/VzKH2JJloBn7ZxWNp4=
X-Google-Smtp-Source: AGHT+IGO2CDvfO6ggNCJrMk/WMP52SfMuSvlIOZb1l3IXfNyWdWCmQGxVjKlEdKBqkaOtA1nqwFPkg==
X-Received: by 2002:a05:600c:c9:b0:406:3fda:962c with SMTP id u9-20020a05600c00c900b004063fda962cmr10388952wmm.31.1696278181893;
        Mon, 02 Oct 2023 13:23:01 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c248800b004063c9f68f2sm7875882wms.26.2023.10.02.13.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 13:23:01 -0700 (PDT)
Message-ID: <651b26a5.050a0220.213bf.e11b@mx.google.com>
X-Google-Original-Message-ID: <ZRsmo7EOttLiZ+KM@Ansuel-xps.>
Date:   Mon, 2 Oct 2023 22:22:59 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Robert Marko <robimarko@gmail.com>, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next] net: phy: aquantia: add firmware load
 support
References: <20230930104008.234831-1-robimarko@gmail.com>
 <df89a28e-0886-4db0-9e68-5f9af5bec888@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df89a28e-0886-4db0-9e68-5f9af5bec888@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 10:18:05PM +0200, Andrew Lunn wrote:
> > +/* load data into the phy's memory */
> > +static int aquantia_load_memory(struct phy_device *phydev, u32 addr,
> > +				const u8 *data, size_t len)
> > +{
> > +	u16 crc = 0, up_crc;
> > +	size_t pos;
> > +
> > +	/* PHY expect addr in LE */
> > +	addr = cpu_to_le32(addr);
> > +
> > +	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > +		      VEND1_GLOBAL_MAILBOX_INTERFACE1,
> > +		      VEND1_GLOBAL_MAILBOX_INTERFACE1_CRC_RESET);
> > +	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > +		      VEND1_GLOBAL_MAILBOX_INTERFACE3,
> > +		      VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR(addr));
> > +	phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > +		      VEND1_GLOBAL_MAILBOX_INTERFACE4,
> > +		      VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR(addr));
> > +
> > +	for (pos = 0; pos < len; pos += min(sizeof(u32), len - pos)) {
> > +		u32 word = 0;
> > +
> > +		memcpy(&word, data + pos, min(sizeof(u32), len - pos));
> > +
> > +		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE5,
> > +			      VEND1_GLOBAL_MAILBOX_INTERFACE5_MSW_DATA(word));
> > +		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE6,
> > +			      VEND1_GLOBAL_MAILBOX_INTERFACE6_LSW_DATA(word));
> > +
> > +		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE1,
> > +			      VEND1_GLOBAL_MAILBOX_INTERFACE1_EXECUTE |
> > +			      VEND1_GLOBAL_MAILBOX_INTERFACE1_WRITE);
> > +
> > +		/* calculate CRC as we load data to the mailbox.
> > +		 * We convert word to big-endiang as PHY is BE and ailbox will
> > +		 * return a BE crc.
> 
> _m_ailbox.
> 
> And i would consistently uses CRC in comments.
> 
> > +static int aqr_fw_boot(struct phy_device *phydev, const u8 *data, size_t size)
> > +{
> > +	const struct aqr_fw_header *header;
> > +	u32 iram_offset = 0, iram_size = 0;
> > +	u32 dram_offset = 0, dram_size = 0;
> > +	char version[VERSION_STRING_SIZE];
> > +	u16 calculated_crc, read_crc;
> > +	u32 primary_offset = 0;
> > +	int ret;
> > +
> > +	/* extract saved crc at the end of the fw */
> > +	memcpy(&read_crc, data + size - 2, sizeof(read_crc));
> > +	/* crc is saved in big-endian as PHY is BE */
> > +	read_crc = be16_to_cpu(read_crc);
> > +	calculated_crc = crc_ccitt_false(0, data, size - 2);
> > +	if (read_crc != calculated_crc) {
> > +		phydev_err(phydev, "bad firmware CRC: file 0x%04x calculated 0x%04x\n",
> > +			   read_crc, calculated_crc);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Get the primary offset to extract DRAM and IRAM sections. */
> > +	memcpy(&primary_offset, data + PRIMARY_OFFSET_OFFSET, sizeof(u16));
> 
> Please add some sanity checks. We should not fully trust the
> firmware. Is PRIMARY_OFFSET_OFFSET + sizeof(u16) actually inside the
> firmware blob?
> 
> > +	primary_offset = PRIMARY_OFFSET(le32_to_cpu(primary_offset));
> > +
> > +	/* Find the DRAM and IRAM sections within the firmware file. */
> > +	header = (struct aqr_fw_header *)(data + primary_offset + HEADER_OFFSET);
> 
> Is header actually inside the firmware blob?
> 
> > +	memcpy(&iram_offset, &header->iram_offset, sizeof(u8) * 3);
> > +	memcpy(&iram_size, &header->iram_size, sizeof(u8) * 3);
> > +	memcpy(&dram_offset, &header->dram_offset, sizeof(u8) * 3);
> > +	memcpy(&dram_size, &header->dram_size, sizeof(u8) * 3);
> > +
> > +	/* offset are in LE and values needs to be converted to cpu endian */
> > +	iram_offset = le32_to_cpu(iram_offset);
> > +	iram_size = le32_to_cpu(iram_size);
> > +	dram_offset = le32_to_cpu(dram_offset);
> > +	dram_size = le32_to_cpu(dram_size);
> > +
> > +	/* Increment the offset with the primary offset. */
> > +	iram_offset += primary_offset;
> > +	dram_offset += primary_offset;
> > +
> > +	phydev_dbg(phydev, "primary %d IRAM offset=%d size=%d DRAM offset=%d size=%d\n",
> > +		   primary_offset, iram_offset, iram_size, dram_offset, dram_size);
> > +
> > +	strscpy(version, (char *)data + dram_offset + VERSION_STRING_OFFSET,
> > +		VERSION_STRING_SIZE);
> 
> Is version inside the blob....
> 
> > +static int aqr_firmware_load_nvmem(struct phy_device *phydev)
> > +{
> > +	struct nvmem_cell *cell;
> > +	size_t size;
> > +	u8 *buf;
> > +	int ret;
> > +
> > +	cell = nvmem_cell_get(&phydev->mdio.dev, "firmware");
> 
> Does this need properties in device tree? Please update the binding.
>

This is problematic... Since this is a plain standard PHY and we don't
have a compatible (as it's matched with the PHY id) we don't have DT to
add this... Sooo how to add this? Should we update the generic-phy dt?

Should we create a dummy dt and add a compatible adding
ethernet-phy.ID... just for this properties?

This is why we were a bit confused about adding a DT commit to this.

> > +
> > +static int aqr_firmware_load_sysfs(struct phy_device *phydev)
> 
> _sysfs seems a bit odd here. Does request_firmware still use the user
> mode helper? I _thought_ it just went direct to the filesystem?
> 
> > +{
> > +	struct device *dev = &phydev->mdio.dev;
> > +	const struct firmware *fw;
> > +	const char *fw_name;
> > +	int ret;
> > +
> > +	ret = of_property_read_string(dev->of_node, "firmware-name",
> > +				      &fw_name);
> 
> Please update the device tree binding.
> 
> > +static int aqr_firmware_load(struct phy_device *phydev)
> > +{
> > +	int ret;
> > +
> > +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_FW_ID);
> > +	if (ret > 0)
> > +		goto exit;
> 
> I assume this means a value of 0 indicates there is no firmware
> running? Maybe a comment or a #define for 0?
> 
> 	 Andrew

-- 
	Ansuel
