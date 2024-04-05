Return-Path: <linux-kernel+bounces-132921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E197899C0B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9249E283FF5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4009816C6AE;
	Fri,  5 Apr 2024 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfK+6cAY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0C32032D;
	Fri,  5 Apr 2024 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712317552; cv=none; b=Z9PS786hwb1oYA0fcgX5C0vE62p4w6uidrLUkCPIad6dScr1rT4M1XrZHimde2cqp6YmByuIdRVt72vxB6R0TcvovEgh5oLbvnfyiLTb5/kPq7RSCW7OZHy2l995I5e4m0RWQM6aSGiIsP5puYfapgrHvdIqERWWRZb2Gye3Pmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712317552; c=relaxed/simple;
	bh=yFjpIS3whW+ZjA1+hS3kVGbmKjV/ELzS5HrcQgHGDig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TL0KXKARa9btYgDYPRDxGq78BDgcnt/H0tP1BV57ePj7xtKJUGysSfNFy4z2rQOCj7YtrACzdTNO3JnQck+xGz1XbmMIPqxDHlbmF08XAlF8/LTko3VpdtjA9oUUZMI5yAYwG3Z3+bHflkMLBYTyG6RUevZmwmaVRjTmXAr86L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfK+6cAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46693C433C7;
	Fri,  5 Apr 2024 11:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712317551;
	bh=yFjpIS3whW+ZjA1+hS3kVGbmKjV/ELzS5HrcQgHGDig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jfK+6cAYZuyNsnDLvCmN0zbLbKymTXGfe+Gt5BQlEzUvR3XEwSrBdkxF1i0Umwt58
	 kWL0OLykxNOuGuYI3Lh+o1WYxOWeVh7QktuxMQQQfCpu1DNvVqtZurJp++jwHTNPcP
	 32Tg9QZATdVxK88acUSs11SNkFXq+5l/NDas+128/ON1HPJLCk6HR+GU7vNJhfqEXP
	 2tBFrSXJyes11GjmcxeYK7P3qvwRc5MJMi1A3JAgZ5+IkaChJyFrdBd2B3WFUoM+za
	 BKC0AhftvobGWtooSKSV24UvzwRpsjRIuLZXJtjoWPQR/UJFXn+a5Zv1bJuNRwA8VT
	 djqG3bpkqUHdw==
Date: Fri, 5 Apr 2024 17:15:47 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 6/7] soundwire: debugfs: add interface to read/write
 commands
Message-ID: <Zg_ka02zLnXrADGj@matsya>
References: <20240326090122.1051806-1-yung-chuan.liao@linux.intel.com>
 <20240326090122.1051806-7-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326090122.1051806-7-yung-chuan.liao@linux.intel.com>

On 26-03-24, 09:01, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> We have an existing debugfs files to read standard registers
> (DP0/SCP/DPn).
> 
> This patch provides a more generic interface to ANY set of read/write
> contiguous registers in a peripheral device. In follow-up patches,
> this interface will be extended to use BRA transfers.
> 
> The sequence is to use the following files added under the existing
> debugsfs directory for each peripheral device:
> 
> command (write 0, read 1)
> num_bytes
> start_address
> firmware_file (only for writes)
> read_buffer (only for reads)
> 
> Example for a read command - this checks the 6 bytes used for
> enumeration.
> 
> cd /sys/kernel/debug/soundwire/master-0-0/sdw\:0\:025d\:0711\:01/
> echo 1 > command
> echo 6 > num_bytes
> echo 0x50 > start_address
> echo 1 > go

can we have a simpler interface? i am not a big fan of this kind of
structure for debugging.

How about two files read_bytes and write_bytes where you read/write
bytes.

echo 0x50 6 > read_bytes
cat read_bytes

in this format I would like to see addr and values (not need to print
address /value words (regmap does that too)

For write

echo start_addr N byte0 byte 1 ... byte N > write_bytes

 
> cat read_buffer
> address 0x50 val 0x30
> address 0x51 val 0x02
> address 0x52 val 0x5d
> address 0x53 val 0x07
> address 0x54 val 0x11
> address 0x55 val 0x01
> 
> Example with a 2-byte firmware file written in DP0 address 0x22
> 
> od -x /lib/firmware/test_firmware
> 0000000 0a37
> 0000002
> 
> cd /sys/kernel/debug/soundwire/master-0-0/sdw\:0\:025d\:0711\:01/
> echo 0 > command
> echo 2 > num_bytes
> echo 0x22 > start_address
> echo "test_firmware" > firmware_file
> echo 1 > go
> 
> cd /sys/kernel/debug/soundwire/master-0-0/sdw\:0\:025d\:0711\:01/
> echo 1 > command
> echo 2 > num_bytes
> echo 0x22 > start_address
> echo 1 > go
> cat read_buffer
> 
> address 0x22 val 0x37
> address 0x23 val 0x0a
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/debugfs.c | 150 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 150 insertions(+)
> 
> diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
> index 67abd7e52f09..6d253d69871d 100644
> --- a/drivers/soundwire/debugfs.c
> +++ b/drivers/soundwire/debugfs.c
> @@ -3,6 +3,7 @@
>  
>  #include <linux/device.h>
>  #include <linux/debugfs.h>
> +#include <linux/firmware.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
> @@ -137,6 +138,145 @@ static int sdw_slave_reg_show(struct seq_file *s_file, void *data)
>  }
>  DEFINE_SHOW_ATTRIBUTE(sdw_slave_reg);
>  
> +#define MAX_CMD_BYTES 256
> +
> +static int cmd;
> +static u32 start_addr;
> +static size_t num_bytes;
> +static u8 read_buffer[MAX_CMD_BYTES];
> +static char *firmware_file;
> +
> +static int set_command(void *data, u64 value)
> +{
> +	struct sdw_slave *slave = data;
> +
> +	if (value > 1)
> +		return -EINVAL;
> +
> +	/* Userspace changed the hardware state behind the kernel's back */
> +	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> +
> +	dev_dbg(&slave->dev, "command: %s\n", value ? "read" : "write");
> +	cmd = value;
> +
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(set_command_fops, NULL,
> +			 set_command, "%llu\n");
> +
> +static int set_start_address(void *data, u64 value)
> +{
> +	struct sdw_slave *slave = data;
> +
> +	/* Userspace changed the hardware state behind the kernel's back */
> +	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> +
> +	dev_dbg(&slave->dev, "start address %#llx\n", value);
> +
> +	start_addr = value;
> +
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(set_start_address_fops, NULL,
> +			 set_start_address, "%llu\n");
> +
> +static int set_num_bytes(void *data, u64 value)
> +{
> +	struct sdw_slave *slave = data;
> +
> +	if (value == 0 || value > MAX_CMD_BYTES)
> +		return -EINVAL;
> +
> +	/* Userspace changed the hardware state behind the kernel's back */
> +	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> +
> +	dev_dbg(&slave->dev, "number of bytes %lld\n", value);
> +
> +	num_bytes = value;
> +
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(set_num_bytes_fops, NULL,
> +			 set_num_bytes, "%llu\n");
> +
> +static int cmd_go(void *data, u64 value)
> +{
> +	struct sdw_slave *slave = data;
> +	int ret;
> +
> +	if (value != 1)
> +		return -EINVAL;
> +
> +	/* one last check */
> +	if (start_addr > SDW_REG_MAX ||
> +	    num_bytes == 0 || num_bytes > MAX_CMD_BYTES)
> +		return -EINVAL;
> +
> +	ret = pm_runtime_get_sync(&slave->dev);
> +	if (ret < 0 && ret != -EACCES) {
> +		pm_runtime_put_noidle(&slave->dev);
> +		return ret;
> +	}
> +
> +	/* Userspace changed the hardware state behind the kernel's back */
> +	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> +
> +	dev_dbg(&slave->dev, "starting command\n");
> +
> +	if (cmd == 0) {
> +		const struct firmware *fw;
> +
> +		ret = request_firmware(&fw, firmware_file, &slave->dev);
> +		if (ret < 0) {
> +			dev_err(&slave->dev, "firmware %s not found\n", firmware_file);
> +			goto out;
> +		}
> +
> +		if (fw->size != num_bytes) {
> +			dev_err(&slave->dev,
> +				"firmware %s: unexpected size %zd, desired %zd\n",
> +				firmware_file, fw->size, num_bytes);
> +			release_firmware(fw);
> +			goto out;
> +		}
> +
> +		ret = sdw_nwrite_no_pm(slave, start_addr, num_bytes, fw->data);
> +		release_firmware(fw);
> +	} else {
> +		ret = sdw_nread_no_pm(slave, start_addr, num_bytes, read_buffer);
> +	}
> +
> +	dev_dbg(&slave->dev, "command completed %d\n", ret);
> +
> +out:
> +	pm_runtime_mark_last_busy(&slave->dev);
> +	pm_runtime_put(&slave->dev);
> +
> +	return ret;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(cmd_go_fops, NULL,
> +			 cmd_go, "%llu\n");
> +
> +#define MAX_LINE_LEN 128
> +
> +static int read_buffer_show(struct seq_file *s_file, void *data)
> +{
> +	char buf[MAX_LINE_LEN];
> +	int i;
> +
> +	if (num_bytes == 0 || num_bytes > MAX_CMD_BYTES)
> +		return -EINVAL;
> +
> +	for (i = 0; i < num_bytes; i++) {
> +		scnprintf(buf, MAX_LINE_LEN, "address %#x val 0x%02x\n",
> +			  start_addr + i, read_buffer[i]);
> +		seq_printf(s_file, "%s", buf);
> +	}
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(read_buffer);
> +
>  void sdw_slave_debugfs_init(struct sdw_slave *slave)
>  {
>  	struct dentry *master;
> @@ -151,6 +291,16 @@ void sdw_slave_debugfs_init(struct sdw_slave *slave)
>  
>  	debugfs_create_file("registers", 0400, d, slave, &sdw_slave_reg_fops);
>  
> +	/* interface to send arbitrary commands */
> +	debugfs_create_file("command", 0200, d, slave, &set_command_fops);
> +	debugfs_create_file("start_address", 0200, d, slave, &set_start_address_fops);
> +	debugfs_create_file("num_bytes", 0200, d, slave, &set_num_bytes_fops);
> +	debugfs_create_file("go", 0200, d, slave, &cmd_go_fops);
> +
> +	debugfs_create_file("read_buffer", 0400, d, slave, &read_buffer_fops);
> +	firmware_file = NULL;
> +	debugfs_create_str("firmware_file", 0200, d, &firmware_file);
> +
>  	slave->debugfs = d;
>  }
>  
> -- 
> 2.34.1

-- 
~Vinod

