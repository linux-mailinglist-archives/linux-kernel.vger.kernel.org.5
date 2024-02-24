Return-Path: <linux-kernel+bounces-79498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F374186234C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 08:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB40A283E51
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 07:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EB910A35;
	Sat, 24 Feb 2024 07:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VKp9epqH"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF88EDF67
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708759260; cv=none; b=kq3YEqpec3iBl5i121JS6Hep+sRLcAQtdAjfTf3gUQ/1GjwEyKa2lduvGxcNUuxPSE+QJdzfUqAGU0319MhAhQCQz0tgg9C4/D5EtXpCEdBjKBqLCQhHIbCN7x0FrNsUO1AbP9Tx1/vH3VHVG41ATqw5ZbOuF1TDX1ZY89NU5kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708759260; c=relaxed/simple;
	bh=NDpx6g0GBAYx1WLUy1CtJJWrIoIkNW9x+ZtLFU/mvUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hs2twzqMR7Ot2mEtDLgEEa+8AaH4LcWNd4MydMtjtGTAXR1qpjc9aO8xBBVXdtyiT/L+vsMZI7xNH9GIZ+UVsR5sKgxmKSkiihXa3Xg9J+NI4IEHQfJ3sUe8UwbQxM4wjdpis/X4a4Ndoedyb/Ge4nOWyZXocKfu2yDICPS0/K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VKp9epqH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1188)
	id BCBFD20B74C0; Fri, 23 Feb 2024 23:20:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BCBFD20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708759251;
	bh=RB5gx2rs9hjlGjI0721a8rvo/EkD4ZsqJTA1tC0mZX8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=VKp9epqHZxxd2/9TaA/CK3CTjNvGUw1i4cNtvLX31CupLPd8hoA/E6N7DQgbM8HxG
	 0n62+zmkUHQkJhs4+/Jf6onszJyURadtun1JaR+NscTZxe5Anqsmk2Mn50XbZinrRJ
	 9UVOV0h3y3jyISItO6mAPGB+J0/+IBtY6eJK/z6I=
Date: Fri, 23 Feb 2024 23:20:51 -0800
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
To: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] firmware: xilinx: Update firmware call interface
 to support additional args
Message-ID: <20240224072051.GA22366@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Reply-To: 20231129112713.22718-1-jay.buddhabhatti@amd.com
References: <20231129112713.22718-1-jay.buddhabhatti@amd.com>
 <20231129112713.22718-2-jay.buddhabhatti@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129112713.22718-2-jay.buddhabhatti@amd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

> Wed, Nov 29, 2023 at 03:27:09AM -0800, Jay Buddhabhatti wrote:
> System-level platform management layer (do_fw_call()) has support for
> maximum of 5 arguments as of now (1 EEMI API ID + 4 command arguments).
> In order to support new EEMI PM_IOCTL IDs (Secure Read/Write), this
> support must be extended to support one additional argument, which
> results in a configuration of - 1 EEMI API ID + 5 command arguments.
> 
> Update zynqmp_pm_invoke_fn() and do_fw_call() with this new definition
> containing variable arguments. As a result, update all the references
> to pm invoke function with the updated definition.
> 
> Co-developed-by: Izhar Ameer Shaikh <izhar.ameer.shaikh@amd.com>
> Signed-off-by: Izhar Ameer Shaikh <izhar.ameer.shaikh@amd.com>
> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c        | 278 +++++++++++-------------
>  drivers/soc/xilinx/xlnx_event_manager.c |   2 +-
>  drivers/soc/xilinx/zynqmp_power.c       |   2 +-
>  include/linux/firmware/xlnx-zynqmp.h    |   3 +-
>  4 files changed, 132 insertions(+), 153 deletions(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index b0d22d4455d9..c9ec2c75cf0a 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -106,8 +106,7 @@ static int zynqmp_pm_ret_code(u32 ret_status)
>  	}
>  }
>  
> -static noinline int do_fw_call_fail(u64 arg0, u64 arg1, u64 arg2,
> -				    u32 *ret_payload)
> +static noinline int do_fw_call_fail(u32 *ret_payload, u32 num_args, ...)
>  {
>  	return -ENODEV;
>  }
> @@ -116,25 +115,35 @@ static noinline int do_fw_call_fail(u64 arg0, u64 arg1, u64 arg2,
>   * PM function call wrapper
>   * Invoke do_fw_call_smc or do_fw_call_hvc, depending on the configuration
>   */
> -static int (*do_fw_call)(u64, u64, u64, u32 *ret_payload) = do_fw_call_fail;
> +static int (*do_fw_call)(u32 *ret_payload, u32, ...) = do_fw_call_fail;
>  
>  /**
>   * do_fw_call_smc() - Call system-level platform management layer (SMC)
> - * @arg0:		Argument 0 to SMC call
> - * @arg1:		Argument 1 to SMC call
> - * @arg2:		Argument 2 to SMC call
> + * @num_args:		Number of variable arguments should be <= 8
>   * @ret_payload:	Returned value array
>   *
>   * Invoke platform management function via SMC call (no hypervisor present).
>   *
>   * Return: Returns status, either success or error+reason
>   */
> -static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
> -				   u32 *ret_payload)
> +static noinline int do_fw_call_smc(u32 *ret_payload, u32 num_args, ...)
>  {
>  	struct arm_smccc_res res;
> +	u64 args[8] = {0};
> +	va_list arg_list;
> +	u8 i;
>  
> -	arm_smccc_smc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
> +	if (num_args > 8)
> +		return -EINVAL;
> +
> +	va_start(arg_list, num_args);
> +
> +	for (i = 0; i < num_args; i++)
> +		args[i] = va_arg(arg_list, u64);
> +
> +	va_end(arg_list);
> +
> +	arm_smccc_smc(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], &res);
>  
>  	if (ret_payload) {
>  		ret_payload[0] = lower_32_bits(res.a0);
> @@ -148,9 +157,7 @@ static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
>  
>  /**
>   * do_fw_call_hvc() - Call system-level platform management layer (HVC)
> - * @arg0:		Argument 0 to HVC call
> - * @arg1:		Argument 1 to HVC call
> - * @arg2:		Argument 2 to HVC call
> + * @num_args:		Number of variable arguments should be <= 8
>   * @ret_payload:	Returned value array
>   *
>   * Invoke platform management function via HVC
> @@ -159,12 +166,24 @@ static noinline int do_fw_call_smc(u64 arg0, u64 arg1, u64 arg2,
>   *
>   * Return: Returns status, either success or error+reason
>   */
> -static noinline int do_fw_call_hvc(u64 arg0, u64 arg1, u64 arg2,
> -				   u32 *ret_payload)
> +static noinline int do_fw_call_hvc(u32 *ret_payload, u32 num_args, ...)
>  {
>  	struct arm_smccc_res res;
> +	u64 args[8] = {0};
> +	va_list arg_list;
> +	u8 i;
> +
> +	if (num_args > 8)
> +		return -EINVAL;
> +
> +	va_start(arg_list, num_args);
> +
> +	for (i = 0; i < num_args; i++)
> +		args[i] = va_arg(arg_list, u64);
>  
> -	arm_smccc_hvc(arg0, arg1, arg2, 0, 0, 0, 0, 0, &res);
> +	va_end(arg_list);
> +
> +	arm_smccc_hvc(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], &res);
>  
>  	if (ret_payload) {
>  		ret_payload[0] = lower_32_bits(res.a0);
> @@ -184,7 +203,7 @@ static int __do_feature_check_call(const u32 api_id, u32 *ret_payload)
>  	smc_arg[0] = PM_SIP_SVC | PM_FEATURE_CHECK;
>  	smc_arg[1] = api_id;
>  
> -	ret = do_fw_call(smc_arg[0], smc_arg[1], 0, ret_payload);
> +	ret = do_fw_call(ret_payload, 2, smc_arg[0], smc_arg[1]);
>  	if (ret)
>  		ret = -EOPNOTSUPP;
>  	else
> @@ -295,11 +314,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_is_function_supported);
>   * zynqmp_pm_invoke_fn() - Invoke the system-level platform management layer
>   *			   caller function depending on the configuration
>   * @pm_api_id:		Requested PM-API call
> - * @arg0:		Argument 0 to requested PM-API call
> - * @arg1:		Argument 1 to requested PM-API call
> - * @arg2:		Argument 2 to requested PM-API call
> - * @arg3:		Argument 3 to requested PM-API call
>   * @ret_payload:	Returned value array
> + * @num_args:		Number of arguments to requested PM-API call
>   *
>   * Invoke platform management function for SMC or HVC call, depending on
>   * configuration.
> @@ -316,26 +332,38 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_is_function_supported);
>   *
>   * Return: Returns status, either success or error+reason
>   */
> -int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
> -			u32 arg2, u32 arg3, u32 *ret_payload)
> +int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 *ret_payload, u32 num_args, ...)
>  {
>  	/*
>  	 * Added SIP service call Function Identifier
>  	 * Make sure to stay in x0 register
>  	 */
> -	u64 smc_arg[4];
> -	int ret;
> +	u64 smc_arg[8];
> +	int ret, i;
> +	va_list arg_list;
> +	u32 args[14] = {0};
> +
> +	if (num_args > 14)
> +		return -EINVAL;
> +
> +	va_start(arg_list, num_args);
>  
>  	/* Check if feature is supported or not */
>  	ret = zynqmp_pm_feature(pm_api_id);
>  	if (ret < 0)
>  		return ret;
>  
> +	for (i = 0; i < num_args; i++)
> +		args[i] = va_arg(arg_list, u32);
> +
> +	va_end(arg_list);
> +
>  	smc_arg[0] = PM_SIP_SVC | pm_api_id;
> -	smc_arg[1] = ((u64)arg1 << 32) | arg0;
> -	smc_arg[2] = ((u64)arg3 << 32) | arg2;
> +	for (i = 0; i < 7; i++)
> +		smc_arg[i + 1] = ((u64)args[(i * 2) + 1] << 32) | args[i * 2];
>  
> -	return do_fw_call(smc_arg[0], smc_arg[1], smc_arg[2], ret_payload);
> +	return do_fw_call(ret_payload, 8, smc_arg[0], smc_arg[1], smc_arg[2], smc_arg[3],
> +			  smc_arg[4], smc_arg[5], smc_arg[6], smc_arg[7]);
>  }
>  
>  static u32 pm_api_version;
> @@ -347,14 +375,12 @@ int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
>  {
>  	int ret;
>  
> -	ret = zynqmp_pm_invoke_fn(TF_A_PM_REGISTER_SGI, sgi_num, reset, 0, 0,
> -				  NULL);
> +	ret = zynqmp_pm_invoke_fn(TF_A_PM_REGISTER_SGI, NULL, 2, sgi_num, reset);
>  	if (!ret)
>  		return ret;
>  
>  	/* try old implementation as fallback strategy if above fails */
> -	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_REGISTER_SGI, sgi_num,
> -				   reset, NULL);
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 3, IOCTL_REGISTER_SGI, sgi_num, reset);
>  }
>  
>  /**
> @@ -376,7 +402,7 @@ int zynqmp_pm_get_api_version(u32 *version)
>  		*version = pm_api_version;
>  		return 0;
>  	}
> -	ret = zynqmp_pm_invoke_fn(PM_GET_API_VERSION, 0, 0, 0, 0, ret_payload);
> +	ret = zynqmp_pm_invoke_fn(PM_GET_API_VERSION, ret_payload, 0);
>  	*version = ret_payload[1];
>  
>  	return ret;
> @@ -399,7 +425,7 @@ int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
>  	if (!idcode || !version)
>  		return -EINVAL;
>  
> -	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
> +	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, ret_payload, 0);
>  	*idcode = ret_payload[1];
>  	*version = ret_payload[2];
>  
> @@ -427,7 +453,7 @@ static int zynqmp_pm_get_family_info(u32 *family, u32 *subfamily)
>  		return 0;
>  	}
>  
> -	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
> +	ret = zynqmp_pm_invoke_fn(PM_GET_CHIPID, ret_payload, 0);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -459,8 +485,7 @@ static int zynqmp_pm_get_trustzone_version(u32 *version)
>  		*version = pm_tz_version;
>  		return 0;
>  	}
> -	ret = zynqmp_pm_invoke_fn(PM_GET_TRUSTZONE_VERSION, 0, 0,
> -				  0, 0, ret_payload);
> +	ret = zynqmp_pm_invoke_fn(PM_GET_TRUSTZONE_VERSION, ret_payload, 0);
>  	*version = ret_payload[1];
>  
>  	return ret;
> @@ -507,8 +532,8 @@ int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
>  {
>  	int ret;
>  
> -	ret = zynqmp_pm_invoke_fn(PM_QUERY_DATA, qdata.qid, qdata.arg1,
> -				  qdata.arg2, qdata.arg3, out);
> +	ret = zynqmp_pm_invoke_fn(PM_QUERY_DATA, out, 4, qdata.qid, qdata.arg1, qdata.arg2,
> +				  qdata.arg3);
>  
>  	/*
>  	 * For clock name query, all bytes in SMC response are clock name
> @@ -530,7 +555,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_query_data);
>   */
>  int zynqmp_pm_clock_enable(u32 clock_id)
>  {
> -	return zynqmp_pm_invoke_fn(PM_CLOCK_ENABLE, clock_id, 0, 0, 0, NULL);
> +	return zynqmp_pm_invoke_fn(PM_CLOCK_ENABLE, NULL, 1, clock_id);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_clock_enable);
>  
> @@ -545,7 +570,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_enable);
>   */
>  int zynqmp_pm_clock_disable(u32 clock_id)
>  {
> -	return zynqmp_pm_invoke_fn(PM_CLOCK_DISABLE, clock_id, 0, 0, 0, NULL);
> +	return zynqmp_pm_invoke_fn(PM_CLOCK_DISABLE, NULL, 1, clock_id);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_clock_disable);
>  
> @@ -564,8 +589,7 @@ int zynqmp_pm_clock_getstate(u32 clock_id, u32 *state)
>  	u32 ret_payload[PAYLOAD_ARG_CNT];
>  	int ret;
>  
> -	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETSTATE, clock_id, 0,
> -				  0, 0, ret_payload);
> +	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETSTATE, ret_payload, 1, clock_id);
>  	*state = ret_payload[1];
>  
>  	return ret;
> @@ -584,8 +608,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getstate);
>   */
>  int zynqmp_pm_clock_setdivider(u32 clock_id, u32 divider)
>  {
> -	return zynqmp_pm_invoke_fn(PM_CLOCK_SETDIVIDER, clock_id, divider,
> -				   0, 0, NULL);
> +	return zynqmp_pm_invoke_fn(PM_CLOCK_SETDIVIDER, NULL, 2, clock_id, divider);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_clock_setdivider);
>  
> @@ -604,8 +627,7 @@ int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider)
>  	u32 ret_payload[PAYLOAD_ARG_CNT];
>  	int ret;
>  
> -	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETDIVIDER, clock_id, 0,
> -				  0, 0, ret_payload);
> +	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETDIVIDER, ret_payload, 1, clock_id);
>  	*divider = ret_payload[1];
>  
>  	return ret;
> @@ -623,10 +645,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getdivider);
>   */
>  int zynqmp_pm_clock_setrate(u32 clock_id, u64 rate)
>  {
> -	return zynqmp_pm_invoke_fn(PM_CLOCK_SETRATE, clock_id,
> -				   lower_32_bits(rate),
> -				   upper_32_bits(rate),
> -				   0, NULL);
> +	return zynqmp_pm_invoke_fn(PM_CLOCK_SETRATE, NULL, 3, clock_id, lower_32_bits(rate),
> +				   upper_32_bits(rate));
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_clock_setrate);
>  
> @@ -645,8 +665,7 @@ int zynqmp_pm_clock_getrate(u32 clock_id, u64 *rate)
>  	u32 ret_payload[PAYLOAD_ARG_CNT];
>  	int ret;
>  
> -	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETRATE, clock_id, 0,
> -				  0, 0, ret_payload);
> +	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETRATE, ret_payload, 1, clock_id);
>  	*rate = ((u64)ret_payload[2] << 32) | ret_payload[1];
>  
>  	return ret;
> @@ -664,8 +683,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getrate);
>   */
>  int zynqmp_pm_clock_setparent(u32 clock_id, u32 parent_id)
>  {
> -	return zynqmp_pm_invoke_fn(PM_CLOCK_SETPARENT, clock_id,
> -				   parent_id, 0, 0, NULL);
> +	return zynqmp_pm_invoke_fn(PM_CLOCK_SETPARENT, NULL, 2, clock_id, parent_id);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_clock_setparent);
>  
> @@ -684,8 +702,7 @@ int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
>  	u32 ret_payload[PAYLOAD_ARG_CNT];
>  	int ret;
>  
> -	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETPARENT, clock_id, 0,
> -				  0, 0, ret_payload);
> +	ret = zynqmp_pm_invoke_fn(PM_CLOCK_GETPARENT, ret_payload, 1, clock_id);
>  	*parent_id = ret_payload[1];
>  
>  	return ret;
> @@ -704,8 +721,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getparent);
>   */
>  int zynqmp_pm_set_pll_frac_mode(u32 clk_id, u32 mode)
>  {
> -	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_PLL_FRAC_MODE,
> -				   clk_id, mode, NULL);
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 4, 0, IOCTL_SET_PLL_FRAC_MODE, clk_id, mode);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_mode);
>  
> @@ -721,8 +737,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_mode);
>   */
>  int zynqmp_pm_get_pll_frac_mode(u32 clk_id, u32 *mode)
>  {
> -	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_PLL_FRAC_MODE,
> -				   clk_id, 0, mode);
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, mode, 3, 0, IOCTL_GET_PLL_FRAC_MODE, clk_id);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_mode);
>  
> @@ -739,8 +754,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_mode);
>   */
>  int zynqmp_pm_set_pll_frac_data(u32 clk_id, u32 data)
>  {
> -	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_PLL_FRAC_DATA,
> -				   clk_id, data, NULL);
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 4, 0, IOCTL_SET_PLL_FRAC_DATA, clk_id, data);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_data);
>  
> @@ -756,8 +770,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_pll_frac_data);
>   */
>  int zynqmp_pm_get_pll_frac_data(u32 clk_id, u32 *data)
>  {
> -	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_PLL_FRAC_DATA,
> -				   clk_id, 0, data);
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, data, 3, 0, IOCTL_GET_PLL_FRAC_DATA, clk_id);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_get_pll_frac_data);
>  
> @@ -778,9 +791,8 @@ int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value)
>  	u32 mask = (node_id == NODE_SD_0) ? GENMASK(15, 0) : GENMASK(31, 16);
>  
>  	if (value) {
> -		return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
> -					   IOCTL_SET_SD_TAPDELAY,
> -					   type, value, NULL);
> +		return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 4, node_id, IOCTL_SET_SD_TAPDELAY, type,
> +					   value);
>  	}
>  
>  	/*
> @@ -798,7 +810,7 @@ int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value)
>  	 * Use PM_MMIO_READ/PM_MMIO_WRITE to re-implement the missing counter
>  	 * part of IOCTL_SET_SD_TAPDELAY which clears SDx_ITAPDLYENA bits.
>  	 */
> -	return zynqmp_pm_invoke_fn(PM_MMIO_WRITE, reg, mask, 0, 0, NULL);
> +	return zynqmp_pm_invoke_fn(PM_MMIO_WRITE, NULL, 2, reg, mask);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_tapdelay);
>  
> @@ -814,8 +826,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_tapdelay);
>   */
>  int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
>  {
> -	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, IOCTL_SD_DLL_RESET,
> -				   type, 0, NULL);
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 3, node_id, IOCTL_SD_DLL_RESET, type);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
>  
> @@ -831,8 +842,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
>   */
>  int zynqmp_pm_ospi_mux_select(u32 dev_id, u32 select)
>  {
> -	return zynqmp_pm_invoke_fn(PM_IOCTL, dev_id, IOCTL_OSPI_MUX_SELECT,
> -				   select, 0, NULL);
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 3, dev_id, IOCTL_OSPI_MUX_SELECT, select);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_ospi_mux_select);
>  
> @@ -847,8 +857,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_ospi_mux_select);
>   */
>  int zynqmp_pm_write_ggs(u32 index, u32 value)
>  {
> -	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_WRITE_GGS,
> -				   index, value, NULL);
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 4, 0, IOCTL_WRITE_GGS, index, value);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_write_ggs);
>  
> @@ -863,8 +872,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_write_ggs);
>   */
>  int zynqmp_pm_read_ggs(u32 index, u32 *value)
>  {
> -	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_READ_GGS,
> -				   index, 0, value);
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, value, 3, 0, IOCTL_READ_GGS, index);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_read_ggs);
>  
> @@ -880,8 +888,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_read_ggs);
>   */
>  int zynqmp_pm_write_pggs(u32 index, u32 value)
>  {
> -	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_WRITE_PGGS, index, value,
> -				   NULL);
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 4, 0, IOCTL_WRITE_PGGS, index, value);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_write_pggs);
>  
> @@ -897,15 +904,13 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_write_pggs);
>   */
>  int zynqmp_pm_read_pggs(u32 index, u32 *value)
>  {
> -	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_READ_PGGS, index, 0,
> -				   value);
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, value, 3, 0, IOCTL_READ_PGGS, index);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_read_pggs);
>  
>  int zynqmp_pm_set_tapdelay_bypass(u32 index, u32 value)
>  {
> -	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_TAPDELAY_BYPASS,
> -				   index, value, NULL);
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 4, 0, IOCTL_SET_TAPDELAY_BYPASS, index, value);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_set_tapdelay_bypass);
>  
> @@ -920,8 +925,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_tapdelay_bypass);
>   */
>  int zynqmp_pm_set_boot_health_status(u32 value)
>  {
> -	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_BOOT_HEALTH_STATUS,
> -				   value, 0, NULL);
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 3, 0, IOCTL_SET_BOOT_HEALTH_STATUS, value);
>  }
>  
>  /**
> @@ -935,8 +939,7 @@ int zynqmp_pm_set_boot_health_status(u32 value)
>  int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
>  			   const enum zynqmp_pm_reset_action assert_flag)
>  {
> -	return zynqmp_pm_invoke_fn(PM_RESET_ASSERT, reset, assert_flag,
> -				   0, 0, NULL);
> +	return zynqmp_pm_invoke_fn(PM_RESET_ASSERT, NULL, 2, reset, assert_flag);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_reset_assert);
>  
> @@ -955,8 +958,7 @@ int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset, u32 *status)
>  	if (!status)
>  		return -EINVAL;
>  
> -	ret = zynqmp_pm_invoke_fn(PM_RESET_GET_STATUS, reset, 0,
> -				  0, 0, ret_payload);
> +	ret = zynqmp_pm_invoke_fn(PM_RESET_GET_STATUS, ret_payload, 1, reset);
>  	*status = ret_payload[1];
>  
>  	return ret;
> @@ -981,9 +983,8 @@ int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags)
>  	u32 ret_payload[PAYLOAD_ARG_CNT];
>  	int ret;
>  
> -	ret = zynqmp_pm_invoke_fn(PM_FPGA_LOAD, lower_32_bits(address),
> -				  upper_32_bits(address), size, flags,
> -				  ret_payload);
> +	ret = zynqmp_pm_invoke_fn(PM_FPGA_LOAD, ret_payload, 4, lower_32_bits(address),
> +				  upper_32_bits(address), size, flags);
>  	if (ret_payload[0])
>  		return -ret_payload[0];
>  
> @@ -1008,7 +1009,7 @@ int zynqmp_pm_fpga_get_status(u32 *value)
>  	if (!value)
>  		return -EINVAL;
>  
> -	ret = zynqmp_pm_invoke_fn(PM_FPGA_GET_STATUS, 0, 0, 0, 0, ret_payload);
> +	ret = zynqmp_pm_invoke_fn(PM_FPGA_GET_STATUS, ret_payload, 0);
>  	*value = ret_payload[1];
>  
>  	return ret;
> @@ -1036,11 +1037,9 @@ int zynqmp_pm_fpga_get_config_status(u32 *value)
>  	lower_addr = lower_32_bits((u64)&buf);
>  	upper_addr = upper_32_bits((u64)&buf);
>  
> -	ret = zynqmp_pm_invoke_fn(PM_FPGA_READ,
> -				  XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET,
> -				  lower_addr, upper_addr,
> -				  XILINX_ZYNQMP_PM_FPGA_READ_CONFIG_REG,
> -				  ret_payload);
> +	ret = zynqmp_pm_invoke_fn(PM_FPGA_READ, ret_payload, 4,
> +				  XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET, lower_addr, upper_addr,
> +				  XILINX_ZYNQMP_PM_FPGA_READ_CONFIG_REG);
>  
>  	*value = ret_payload[1];
>  
> @@ -1058,7 +1057,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_get_config_status);
>   */
>  int zynqmp_pm_pinctrl_request(const u32 pin)
>  {
> -	return zynqmp_pm_invoke_fn(PM_PINCTRL_REQUEST, pin, 0, 0, 0, NULL);
> +	return zynqmp_pm_invoke_fn(PM_PINCTRL_REQUEST, NULL, 1, pin);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_request);
>  
> @@ -1072,7 +1071,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_request);
>   */
>  int zynqmp_pm_pinctrl_release(const u32 pin)
>  {
> -	return zynqmp_pm_invoke_fn(PM_PINCTRL_RELEASE, pin, 0, 0, 0, NULL);
> +	return zynqmp_pm_invoke_fn(PM_PINCTRL_RELEASE, NULL, 1, pin);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_release);
>  
> @@ -1093,8 +1092,7 @@ int zynqmp_pm_pinctrl_get_function(const u32 pin, u32 *id)
>  	if (!id)
>  		return -EINVAL;
>  
> -	ret = zynqmp_pm_invoke_fn(PM_PINCTRL_GET_FUNCTION, pin, 0,
> -				  0, 0, ret_payload);
> +	ret = zynqmp_pm_invoke_fn(PM_PINCTRL_GET_FUNCTION, ret_payload, 1, pin);
>  	*id = ret_payload[1];
>  
>  	return ret;
> @@ -1112,8 +1110,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_get_function);
>   */
>  int zynqmp_pm_pinctrl_set_function(const u32 pin, const u32 id)
>  {
> -	return zynqmp_pm_invoke_fn(PM_PINCTRL_SET_FUNCTION, pin, id,
> -				   0, 0, NULL);
> +	return zynqmp_pm_invoke_fn(PM_PINCTRL_SET_FUNCTION, NULL, 2, pin, id);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_set_function);
>  
> @@ -1136,8 +1133,7 @@ int zynqmp_pm_pinctrl_get_config(const u32 pin, const u32 param,
>  	if (!value)
>  		return -EINVAL;
>  
> -	ret = zynqmp_pm_invoke_fn(PM_PINCTRL_CONFIG_PARAM_GET, pin, param,
> -				  0, 0, ret_payload);
> +	ret = zynqmp_pm_invoke_fn(PM_PINCTRL_CONFIG_PARAM_GET, ret_payload, 2, pin, param);
>  	*value = ret_payload[1];
>  
>  	return ret;
> @@ -1166,8 +1162,7 @@ int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
>  			return -EOPNOTSUPP;
>  	}
>  
> -	return zynqmp_pm_invoke_fn(PM_PINCTRL_CONFIG_PARAM_SET, pin,
> -				   param, value, 0, NULL);
> +	return zynqmp_pm_invoke_fn(PM_PINCTRL_CONFIG_PARAM_SET, NULL, 3, pin, param, value);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_set_config);
>  
> @@ -1185,8 +1180,7 @@ unsigned int zynqmp_pm_bootmode_read(u32 *ps_mode)
>  	unsigned int ret;
>  	u32 ret_payload[PAYLOAD_ARG_CNT];
>  
> -	ret = zynqmp_pm_invoke_fn(PM_MMIO_READ, CRL_APB_BOOT_PIN_CTRL, 0,
> -				  0, 0, ret_payload);
> +	ret = zynqmp_pm_invoke_fn(PM_MMIO_READ, ret_payload, 1, CRL_APB_BOOT_PIN_CTRL);
>  
>  	*ps_mode = ret_payload[1];
>  
> @@ -1205,8 +1199,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_bootmode_read);
>   */
>  int zynqmp_pm_bootmode_write(u32 ps_mode)
>  {
> -	return zynqmp_pm_invoke_fn(PM_MMIO_WRITE, CRL_APB_BOOT_PIN_CTRL,
> -				   CRL_APB_BOOTPIN_CTRL_MASK, ps_mode, 0, NULL);
> +	return zynqmp_pm_invoke_fn(PM_MMIO_WRITE, NULL, 3, CRL_APB_BOOT_PIN_CTRL,
> +				   CRL_APB_BOOTPIN_CTRL_MASK, ps_mode);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_bootmode_write);
>  
> @@ -1221,7 +1215,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_bootmode_write);
>   */
>  int zynqmp_pm_init_finalize(void)
>  {
> -	return zynqmp_pm_invoke_fn(PM_PM_INIT_FINALIZE, 0, 0, 0, 0, NULL);
> +	return zynqmp_pm_invoke_fn(PM_PM_INIT_FINALIZE, NULL, 0);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_init_finalize);
>  
> @@ -1235,7 +1229,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_init_finalize);
>   */
>  int zynqmp_pm_set_suspend_mode(u32 mode)
>  {
> -	return zynqmp_pm_invoke_fn(PM_SET_SUSPEND_MODE, mode, 0, 0, 0, NULL);
> +	return zynqmp_pm_invoke_fn(PM_SET_SUSPEND_MODE, NULL, 1, mode);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_set_suspend_mode);
>  
> @@ -1254,8 +1248,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_suspend_mode);
>  int zynqmp_pm_request_node(const u32 node, const u32 capabilities,
>  			   const u32 qos, const enum zynqmp_pm_request_ack ack)
>  {
> -	return zynqmp_pm_invoke_fn(PM_REQUEST_NODE, node, capabilities,
> -				   qos, ack, NULL);
> +	return zynqmp_pm_invoke_fn(PM_REQUEST_NODE, NULL, 4, node, capabilities, qos, ack);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_request_node);
>  
> @@ -1271,7 +1264,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_request_node);
>   */
>  int zynqmp_pm_release_node(const u32 node)
>  {
> -	return zynqmp_pm_invoke_fn(PM_RELEASE_NODE, node, 0, 0, 0, NULL);
> +	return zynqmp_pm_invoke_fn(PM_RELEASE_NODE, NULL, 1, node);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
>  
> @@ -1290,8 +1283,7 @@ int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode)
>  	u32 ret_payload[PAYLOAD_ARG_CNT];
>  	int ret;
>  
> -	ret = zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
> -				  IOCTL_GET_RPU_OPER_MODE, 0, 0, ret_payload);
> +	ret = zynqmp_pm_invoke_fn(PM_IOCTL, ret_payload, 2, node_id, IOCTL_GET_RPU_OPER_MODE);
>  
>  	/* only set rpu_mode if no error */
>  	if (ret == XST_PM_SUCCESS)
> @@ -1313,9 +1305,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_get_rpu_mode);
>   */
>  int zynqmp_pm_set_rpu_mode(u32 node_id, enum rpu_oper_mode rpu_mode)
>  {
> -	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
> -				   IOCTL_SET_RPU_OPER_MODE, (u32)rpu_mode,
> -				   0, NULL);
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 3, node_id, IOCTL_SET_RPU_OPER_MODE,
> +				   (u32)rpu_mode);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_set_rpu_mode);
>  
> @@ -1331,9 +1322,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_rpu_mode);
>   */
>  int zynqmp_pm_set_tcm_config(u32 node_id, enum rpu_tcm_comb tcm_mode)
>  {
> -	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
> -				   IOCTL_TCM_COMB_CONFIG, (u32)tcm_mode, 0,
> -				   NULL);
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 3, node_id, IOCTL_TCM_COMB_CONFIG,
> +				   (u32)tcm_mode);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_set_tcm_config);
>  
> @@ -1348,7 +1338,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_tcm_config);
>  int zynqmp_pm_force_pwrdwn(const u32 node,
>  			   const enum zynqmp_pm_request_ack ack)
>  {
> -	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, node, ack, 0, 0, NULL);
> +	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, NULL, 2, node, ack);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_force_pwrdwn);
>  
> @@ -1367,8 +1357,8 @@ int zynqmp_pm_request_wake(const u32 node,
>  			   const enum zynqmp_pm_request_ack ack)
>  {
>  	/* set_addr flag is encoded into 1st bit of address */
> -	return zynqmp_pm_invoke_fn(PM_REQUEST_WAKEUP, node, address | set_addr,
> -				   address >> 32, ack, NULL);
> +	return zynqmp_pm_invoke_fn(PM_REQUEST_WAKEUP, NULL, 4, node, address | set_addr,
> +				   address >> 32, ack);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_request_wake);
>  
> @@ -1388,8 +1378,7 @@ int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
>  			      const u32 qos,
>  			      const enum zynqmp_pm_request_ack ack)
>  {
> -	return zynqmp_pm_invoke_fn(PM_SET_REQUIREMENT, node, capabilities,
> -				   qos, ack, NULL);
> +	return zynqmp_pm_invoke_fn(PM_SET_REQUIREMENT, NULL, 4, node, capabilities, qos, ack);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_set_requirement);
>  
> @@ -1404,9 +1393,8 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_requirement);
>   */
>  int zynqmp_pm_load_pdi(const u32 src, const u64 address)
>  {
> -	return zynqmp_pm_invoke_fn(PM_LOAD_PDI, src,
> -				   lower_32_bits(address),
> -				   upper_32_bits(address), 0, NULL);
> +	return zynqmp_pm_invoke_fn(PM_LOAD_PDI, NULL, 3, src, lower_32_bits(address),
> +				   upper_32_bits(address));
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_load_pdi);
>  
> @@ -1426,9 +1414,8 @@ int zynqmp_pm_aes_engine(const u64 address, u32 *out)
>  	if (!out)
>  		return -EINVAL;
>  
> -	ret = zynqmp_pm_invoke_fn(PM_SECURE_AES, upper_32_bits(address),
> -				  lower_32_bits(address),
> -				  0, 0, ret_payload);
> +	ret = zynqmp_pm_invoke_fn(PM_SECURE_AES, ret_payload, 2, upper_32_bits(address),
> +				  lower_32_bits(address));
>  	*out = ret_payload[1];
>  
>  	return ret;
> @@ -1456,8 +1443,7 @@ int zynqmp_pm_sha_hash(const u64 address, const u32 size, const u32 flags)
>  	u32 lower_addr = lower_32_bits(address);
>  	u32 upper_addr = upper_32_bits(address);
>  
> -	return zynqmp_pm_invoke_fn(PM_SECURE_SHA, upper_addr, lower_addr,
> -				   size, flags, NULL);
> +	return zynqmp_pm_invoke_fn(PM_SECURE_SHA, NULL, 4, upper_addr, lower_addr, size, flags);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_sha_hash);
>  
> @@ -1479,8 +1465,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_sha_hash);
>  int zynqmp_pm_register_notifier(const u32 node, const u32 event,
>  				const u32 wake, const u32 enable)
>  {
> -	return zynqmp_pm_invoke_fn(PM_REGISTER_NOTIFIER, node, event,
> -				   wake, enable, NULL);
> +	return zynqmp_pm_invoke_fn(PM_REGISTER_NOTIFIER, NULL, 4, node, event, wake, enable);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_register_notifier);
>  
> @@ -1493,8 +1478,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_register_notifier);
>   */
>  int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
>  {
> -	return zynqmp_pm_invoke_fn(PM_SYSTEM_SHUTDOWN, type, subtype,
> -				   0, 0, NULL);
> +	return zynqmp_pm_invoke_fn(PM_SYSTEM_SHUTDOWN, NULL, 2, type, subtype);
>  }
>  
>  /**
> @@ -1506,8 +1490,7 @@ int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
>   */
>  int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value)
>  {
> -	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_FEATURE_CONFIG,
> -				   id, value, NULL);
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 4, 0, IOCTL_SET_FEATURE_CONFIG, id, value);
>  }
>  
>  /**
> @@ -1520,8 +1503,7 @@ int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value)
>  int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
>  				 u32 *payload)
>  {
> -	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_GET_FEATURE_CONFIG,
> -				   id, 0, payload);
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, payload, 3, 0, IOCTL_GET_FEATURE_CONFIG, id);
>  }
>  
>  /**
> @@ -1534,8 +1516,7 @@ int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
>   */
>  int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value)
>  {
> -	return zynqmp_pm_invoke_fn(PM_IOCTL, node, IOCTL_SET_SD_CONFIG,
> -				   config, value, NULL);
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 4, node, IOCTL_SET_SD_CONFIG, config, value);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_config);
>  
> @@ -1550,8 +1531,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_config);
>  int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
>  			     u32 value)
>  {
> -	return zynqmp_pm_invoke_fn(PM_IOCTL, node, IOCTL_SET_GEM_CONFIG,
> -				   config, value, NULL);
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 4, node, IOCTL_SET_GEM_CONFIG, config, value);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_set_gem_config);
>  
> diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
> index 86a048a10a13..adb875f89829 100644
> --- a/drivers/soc/xilinx/xlnx_event_manager.c
> +++ b/drivers/soc/xilinx/xlnx_event_manager.c
> @@ -483,7 +483,7 @@ static void xlnx_call_notify_cb_handler(const u32 *payload)
>  
>  static void xlnx_get_event_callback_data(u32 *buf)
>  {
> -	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, buf);
> +	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, buf, 0);
>  }
>  
>  static irqreturn_t xlnx_event_handler(int irq, void *dev_id)
> diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
> index c2c819701eec..0de0acf80ef8 100644
> --- a/drivers/soc/xilinx/zynqmp_power.c
> +++ b/drivers/soc/xilinx/zynqmp_power.c
> @@ -51,7 +51,7 @@ static enum pm_suspend_mode suspend_mode = PM_SUSPEND_MODE_STD;
>  
>  static void zynqmp_pm_get_callback_data(u32 *buf)
>  {
> -	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, buf);
> +	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, buf, 0);
>  }
>  
>  static void suspend_event_callback(const u32 *payload, void *data)
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index d1ea3898564c..a7e24f5a71b6 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -509,8 +509,7 @@ struct zynqmp_pm_query_data {
>  	u32 arg3;
>  };
>  
> -int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
> -			u32 arg2, u32 arg3, u32 *ret_payload);
> +int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 *ret_payload, u32 num_args, ...);
>  
>  #if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
>  int zynqmp_pm_get_api_version(u32 *version);

Looks good to me.

Reviewed-by: Prasanna Kumar TSM <ptsm@linux.microsoft.com>

