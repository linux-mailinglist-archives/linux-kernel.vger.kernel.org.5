Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A667980D341
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344277AbjLKRGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343918AbjLKRGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:06:33 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFE08E;
        Mon, 11 Dec 2023 09:06:39 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BBB4kVc008107;
        Mon, 11 Dec 2023 18:06:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=V+n7Sp5bVFSiw+ZArYvjC3tZ4rpfA0oH6dYaEQW1ZSk=; b=0O
        Vo0g4/xaHHqwhMs9/fv30WC7oESqPBU/8vVgq9AUMcY+votQ0nDWL7uIO1AJy+eZ
        LhnK5vLPJPuMbO4rG45gV4gCUsYXkI1VjRrlmR5d7gGZhXIjXim4tBjDEwBKF36S
        8J4K5lm9VJ4OO9VqyZaOmb6UDSNyw6E3A1+JBJhYAzHNhx+Up48vntOeWRZJuMWu
        Nwzu5/H6bSa1+XQy4qpNNvEjgrELXzhDiNRogfkf4eUpkA5+XUjp4rwr3wjEKjF7
        KTtsyYby42gEBKzexDGvGKB3ZNpZTFWFndQMRFL/wHdIfz481SgKhEyWrABuybVZ
        Ot2O0yQt4BlB6Fl3aDIg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uvg0gqnku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 18:06:35 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D7B0710005C;
        Mon, 11 Dec 2023 18:06:33 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5B0DF280A02;
        Mon, 11 Dec 2023 18:06:33 +0100 (CET)
Received: from [10.201.20.59] (10.201.20.59) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Dec
 2023 18:06:32 +0100
Message-ID: <485290b9-8150-47c1-9a59-771a8e3848e3@foss.st.com>
Date:   Mon, 11 Dec 2023 18:06:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] tools/counter: add a flexible watch events tool
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231206164726.418990-1-fabrice.gasnier@foss.st.com>
 <20231206164726.418990-2-fabrice.gasnier@foss.st.com>
 <ZXcxaFRuGJg6kYuT@ubuntu-server-vm-macos>
Content-Language: en-US
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <ZXcxaFRuGJg6kYuT@ubuntu-server-vm-macos>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.59]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_07,2023-12-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 16:57, William Breathitt Gray wrote:
> On Wed, Dec 06, 2023 at 05:47:25PM +0100, Fabrice Gasnier wrote:
>> This adds a new counter tool to be able to test various watch events.
>> A flexible watch array can be populated from command line, each field
>> may be tuned with a dedicated command line sub-option in "--watch" string.
>> Several watch events can be defined, each can have specific watch options,
>> by using "--watch <watch 1 options> --watch <watch 2 options>".
>> Watch options is a comma separated list.
>>
>> It also comes with a simple default watch (to monitor overflow/underflow
>> events), used when no watch parameters are provided. It's equivalent to:
>> counter_watch_events -w comp_count,scope_count,evt_ovf_udf
>>
>> The print_usage() routine proposes another example, from the command line,
>> which generates a 2 elements watch array, to monitor:
>> - overflow underflow events
>> - capture events, on channel 3, that reads read captured data by
>>   specifying the component id (capture3_component_id being 7 here).
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>> ---
>> Changes in v3:
>> - Free the allocated memory, also close the char device
>> - Split of another patch series[1].
>> [1] https://lore.kernel.org/lkml/20230922143920.3144249-1-fabrice.gasnier@foss.st.com/
> 
> Hi Fabrice,
> 
> Thank you for splitting this from the other patches. I think you may
> still be leaking memory in a few places below.
> 
>> +	if (nwatch) {
>> +		watches = calloc(nwatch, sizeof(*watches));
>> +		if (!watches) {
>> +			perror("Error allocating watches");
>> +			return 1;
>> +		}
>> +	} else {
>> +		/* default to simple watch example */
>> +		watches = simple_watch;
>> +		nwatch = ARRAY_SIZE(simple_watch);
>> +	}
> 
> If we go down the calloc() path, then we should free the memory
> before any return.

Hi William,

Ah yes, I missed that. I'll fix it in later revision, Thanks!

Best Regards,
Fabrice

> 
>> +				case WATCH_CHANNEL:
>> +					if (!value) {
>> +						fprintf(stderr, "Missing chan=<number>\n");
>> +						return -EINVAL;
> 
> Such as here.
> 
>> +					}
>> +					watches[i].channel = strtoul(value, NULL, 10);
>> +					if (errno)
>> +						return -errno;
> 
> Here.
> 
>> +					break;
>> +				case WATCH_ID:
>> +					if (!value) {
>> +						fprintf(stderr, "Missing id=<number>\n");
>> +						return -EINVAL;
> 
> Here.
> 
>> +					}
>> +					watches[i].component.id = strtoul(value, NULL, 10);
>> +					if (errno)
>> +						return -errno;
> 
> Here.
> 
>> +					break;
>> +				case WATCH_PARENT:
>> +					if (!value) {
>> +						fprintf(stderr, "Missing parent=<number>\n");
>> +						return -EINVAL;
> 
> Here.
> 
>> +					}
>> +					watches[i].component.parent = strtoul(value, NULL, 10);
>> +					if (errno)
>> +						return -errno;
> 
> Here.
> 
>> +					break;
>> +				default:
>> +					fprintf(stderr, "Unknown suboption '%s'\n", value);
>> +					return -EINVAL;
> 
> Here.
> 
>> +	ret = asprintf(&device_name, "/dev/counter%d", dev_num);
>> +	if (ret < 0)
>> +		return -ENOMEM;
> 
> Here.
> 
>> +	fd = open(device_name, O_RDWR);
>> +	if (fd == -1) {
>> +		perror("Unable to open counter device");
>> +		return 1;
> 
> Here.
> 
>> +	}
>> +
>> +	for (i = 0; i < nwatch; i++) {
>> +		ret = ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches + i);
>> +		if (ret == -1) {
>> +			fprintf(stderr, "Error adding watches[%d]: %s\n", i,
>> +				strerror(errno));
>> +			return 1;
> 
> Here.
> 
>> +		}
>> +	}
>> +
>> +	ret = ioctl(fd, COUNTER_ENABLE_EVENTS_IOCTL);
>> +	if (ret == -1) {
>> +		perror("Error enabling events");
>> +		return 1;
> 
> Here.
> 
>> +	}
>> +
>> +	for (i = 0; loop <= 0 || i < loop; i++) {
>> +		ret = read(fd, &event_data, sizeof(event_data));
>> +		if (ret == -1) {
>> +			perror("Failed to read event data");
>> +			return 1;
> 
> Here.
> 
>> +		}
>> +
>> +		if (ret != sizeof(event_data)) {
>> +			fprintf(stderr, "Failed to read event data\n");
>> +			return -EIO;
> 
> And here.
> 
>> +	if (watches != simple_watch)
>> +		free(watches);
>> +	close(fd);
>> +
>> +	return 0;
> 
> We finally free watches here, close the file descriptor, and return. So
> instead of returning an error code directly when you encounter a
> problem, I would do an unwinding goto section like the following
> instead.
> 
> First, the open() call occurs after the calloc(), so move the close()
> call above the watches check so that we unwind in a first-in-last-out
> order. Next, add a label to mark the file descriptor close section, and
> another label to mark the watches free section. Then, rather than
> returning 0 directly, return a retval that we can set. That way, when
> you need to return on an error, set retval to the error code and goto
> the file descriptor close label if we're past the open() call, or the
> watches free label if we're just past the calloc() call.
> 
> William Breathitt Gray
