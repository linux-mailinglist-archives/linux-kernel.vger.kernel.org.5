Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2327A1629
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 08:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjIOGdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 02:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjIOGc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:32:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AA9CCD;
        Thu, 14 Sep 2023 23:32:54 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38F6591J011488;
        Fri, 15 Sep 2023 06:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UPTzuiyLbqpY2BazsAY5AJUexVNIMqd123LNalCL4Gc=;
 b=WjjEoS8Lh5PxhLLm4fD8hxuH+drxEeTjdW6Dr3G+PATCk9Ei9MnfmBQuB/QrzgecmEo8
 JBpmIy0+sj0cPL1/EUXvvua34bExAEOpacZMSsnv5chwaPmZ1ONPCUokp/jwAbCJtrVt
 6dWPxrSyKGDtO78ycDdO2LOiCE/Pmm+50Ffz5mZ1zxH1/jhSASUQQGYu/vH1wqiGeeZB
 x7haVu/3rku5Rp3U62surKknTGZGnges58W6wZl49aY5QV3dlzH3Nz7boR8vPpI+qvyR
 erUmtT4N1Qc96keoArXgZt+ssgMZqezVw/SSDDfgUpNKVTBPbJkObOmNwd7z7N+e8Qcf fQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4g0709dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 06:32:47 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38F6Wkkb006921
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Sep 2023 06:32:46 GMT
Received: from [10.216.46.193] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 14 Sep
 2023 23:32:43 -0700
Message-ID: <fb257d0f-2e6e-400f-a654-18e3c59af1a3@quicinc.com>
Date:   Fri, 15 Sep 2023 12:02:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH v3] usb: gadget: f_uac2: uevent changes for uac2
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jing Leng <jleng@ambarella.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230829092132.1940-1-quic_akakum@quicinc.com>
Content-Language: en-US
From:   AKASH KUMAR <quic_akakum@quicinc.com>
In-Reply-To: <20230829092132.1940-1-quic_akakum@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3ivyhkxh3t-zT6RDpLKj-8W4OBAGxPxN
X-Proofpoint-ORIG-GUID: 3ivyhkxh3t-zT6RDpLKj-8W4OBAGxPxN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_05,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1011 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=924 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle Reminder!!!

On 8/29/2023 2:51 PM, Akash Kumar wrote:
> Adding uevent from usb audio gadget driver for uac2 playback/capture
> events, which userspace reads and later reads sysfs entry to know if
> playback or capture has stopped or started by host application.
>
> /config/usb_gadget/g1/functions/uac2.0 # cat c_status
> 1  --> capture started
> 0  --> capture stopped
> /config/usb_gadget/g1/functions/uac2.0 # cat p_status
> 1 --> playback started
> 0 --> playback stopped
>
> Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
> ---
>   Documentation/usb/gadget-testing.rst |  6 ++++
>   drivers/usb/gadget/function/f_uac2.c | 47 ++++++++++++++++++++++++++++
>   drivers/usb/gadget/function/u_uac2.h |  5 +++
>   3 files changed, 58 insertions(+)
>
> diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
> index 2eeb3e9299e4..b2fded232ced 100644
> --- a/Documentation/usb/gadget-testing.rst
> +++ b/Documentation/usb/gadget-testing.rst
> @@ -733,6 +733,12 @@ The uac2 function provides these attributes in its function directory:
>   	p_ssize		playback sample size (bytes)
>   	req_number	the number of pre-allocated request for both capture
>   			and playback
> +        c_status        audio capture state
> +                        (0: capture stopped, 1: capture started)
> +        p_status        audio playback state
> +                        (0: playback stopped, 1: playback started)
> +        c_status        audio capture state
> +        p_status        audio playback state
>   	=============== ====================================================
>   
>   The attributes have sane default values.
> diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
> index db2d4980cb35..f1f7631e9380 100644
> --- a/drivers/usb/gadget/function/f_uac2.c
> +++ b/drivers/usb/gadget/function/f_uac2.c
> @@ -739,6 +739,8 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
>   	struct usb_gadget *gadget = cdev->gadget;
>   	struct device *dev = &gadget->dev;
>   	int ret = 0;
> +	struct f_uac2_opts *audio_opts =
> +		container_of(fn->fi, struct f_uac2_opts, func_inst);
>   
>   	/* No i/f has more than 2 alt settings */
>   	if (alt > 1) {
> @@ -762,6 +764,8 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
>   			ret = u_audio_start_capture(&uac2->g_audio);
>   		else
>   			u_audio_stop_capture(&uac2->g_audio);
> +		audio_opts->c_status = alt;
> +		schedule_work(&audio_opts->work);
>   	} else if (intf == uac2->as_in_intf) {
>   		uac2->as_in_alt = alt;
>   
> @@ -769,6 +773,8 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
>   			ret = u_audio_start_playback(&uac2->g_audio);
>   		else
>   			u_audio_stop_playback(&uac2->g_audio);
> +		audio_opts->p_status = alt;
> +		schedule_work(&audio_opts->work);
>   	} else {
>   		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
>   		return -EINVAL;
> @@ -801,11 +807,16 @@ static void
>   afunc_disable(struct usb_function *fn)
>   {
>   	struct f_uac2 *uac2 = func_to_uac2(fn);
> +	struct f_uac2_opts *audio_opts =
> +		container_of(fn->fi, struct f_uac2_opts, func_inst);
>   
>   	uac2->as_in_alt = 0;
>   	uac2->as_out_alt = 0;
> +	audio_opts->p_status = 0;//alt;
> +	audio_opts->c_status = 0; //alt;
>   	u_audio_stop_capture(&uac2->g_audio);
>   	u_audio_stop_playback(&uac2->g_audio);
> +	schedule_work(&audio_opts->work);
>   }
>   
>   static int
> @@ -1036,6 +1047,25 @@ UAC2_ATTRIBUTE(c_srate);
>   UAC2_ATTRIBUTE(c_ssize);
>   UAC2_ATTRIBUTE(req_number);
>   
> +#define UAC2_ATTRIBUTE_RO(name)                                         \
> +	static ssize_t f_uac2_opts_##name##_show(                       \
> +			struct config_item *item,                       \
> +			char *page)                                     \
> +{                                                                       \
> +	struct f_uac2_opts *opts = to_f_uac2_opts(item);                \
> +	int result;                                                     \
> +									\
> +	mutex_lock(&opts->lock);                                        \
> +	result = scnprintf(page, PAGE_SIZE, "%u\n", opts->name);        \
> +	mutex_unlock(&opts->lock);                                      \
> +									\
> +	return result;                                                  \
> +}                                                                       \
> +CONFIGFS_ATTR_RO(f_uac2_opts_, name)
> +
> +UAC2_ATTRIBUTE_RO(c_status);
> +UAC2_ATTRIBUTE_RO(p_status);
> +
>   static struct configfs_attribute *f_uac2_attrs[] = {
>   	&f_uac2_opts_attr_p_chmask,
>   	&f_uac2_opts_attr_p_srate,
> @@ -1044,6 +1074,8 @@ static struct configfs_attribute *f_uac2_attrs[] = {
>   	&f_uac2_opts_attr_c_srate,
>   	&f_uac2_opts_attr_c_ssize,
>   	&f_uac2_opts_attr_req_number,
> +	&f_uac2_opts_attr_c_status,
> +	&f_uac2_opts_attr_p_status,
>   	NULL,
>   };
>   
> @@ -1053,11 +1085,23 @@ static const struct config_item_type f_uac2_func_type = {
>   	.ct_owner	= THIS_MODULE,
>   };
>   
> +static void f_uac2_audio_status_change_work(struct work_struct *data)
> +{
> +	struct f_uac2_opts *audio_opts =
> +		container_of(data, struct f_uac2_opts, work);
> +	char *envp[2] = { "UAC2_STATE=Changed", NULL };
> +
> +	kobject_uevent_env(&audio_opts->device->kobj,
> +			KOBJ_CHANGE, envp);
> +}
> +
>   static void afunc_free_inst(struct usb_function_instance *f)
>   {
>   	struct f_uac2_opts *opts;
>   
>   	opts = container_of(f, struct f_uac2_opts, func_inst);
> +	device_destroy(opts->device->class, opts->device->devt);
> +	cancel_work_sync(&opts->work);
>   	kfree(opts);
>   }
>   
> @@ -1082,6 +1126,9 @@ static struct usb_function_instance *afunc_alloc_inst(void)
>   	opts->c_srate = UAC2_DEF_CSRATE;
>   	opts->c_ssize = UAC2_DEF_CSSIZE;
>   	opts->req_number = UAC2_DEF_REQ_NUM;
> +	INIT_WORK(&opts->work, f_uac2_audio_status_change_work);
> +	opts->device = create_function_device("f_uac2");
> +
>   	return &opts->func_inst;
>   }
>   
> diff --git a/drivers/usb/gadget/function/u_uac2.h b/drivers/usb/gadget/function/u_uac2.h
> index b5035711172d..3ccf2eb002f1 100644
> --- a/drivers/usb/gadget/function/u_uac2.h
> +++ b/drivers/usb/gadget/function/u_uac2.h
> @@ -36,6 +36,11 @@ struct f_uac2_opts {
>   
>   	struct mutex			lock;
>   	int				refcnt;
> +	int				c_status;
> +	int				p_status;
> +	struct device			*device;
> +	struct work_struct		work;
>   };
>   
> +extern struct device *create_function_device(char *name);
>   #endif
