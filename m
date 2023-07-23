Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2111275E444
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjGWTGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWTGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:06:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9B8180;
        Sun, 23 Jul 2023 12:06:04 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NIrap4010085;
        Sun, 23 Jul 2023 19:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=+qVwr+ZCWjDtM4Nx+Quv3Q01SRj6JrTXAeRykf1behw=;
 b=NctOqpSLHrXIHb6NXpBIBq2/sH6L47N7EVJHgpcvZ0xU8a4KybpygvI6A6oD0YFAk0hJ
 DvCG6wdJGM59oMyQIBb1vUaFTYc+0EThOyShllosk+ZKo88rlFTIO+usdA01ypdc0xtz
 DtY9Oe29oJw++k0peoeLyCGHyszKX8V/SnMjzkCxvhN6GP3uTyt6xUgFD5MN+KZvtaoQ
 HiApWdQ0R/9VsJkg/hrUpMPzeGX2pETI6tn7ec7tTmXW9eYmZFyu0nqrlKUhrDL5naM7
 QKWnXHOmwrcKu8wECseSvJQOru9a5bh/trvGky88NK50/blZDp80SlwGp5yrZo26zsbx hw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s064dhx46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Jul 2023 19:05:58 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36NJ5vF7000812
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Jul 2023 19:05:57 GMT
Received: from hu-akakum-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 23 Jul 2023 12:05:54 -0700
From:   Akash Kumar <quic_akakum@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jing Leng <jleng@ambarella.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     =?UTF-8?q?Pratham=20Pratap=C2=A0?= <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Akash Kumar <quic_akakum@quicinc.com>
Subject: [PATCH v2] usb: gadget: f_uac2: uevent changes for uac2
Date:   Mon, 24 Jul 2023 00:35:38 +0530
Message-ID: <20230723190538.27750-1-quic_akakum@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cWNXba0orx_jn8kKKcTH8Mtc2XAPOLCN
X-Proofpoint-ORIG-GUID: cWNXba0orx_jn8kKKcTH8Mtc2XAPOLCN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-23_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 phishscore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307230179
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding uevent from usb audio gadget driver for uac2 playback/capture
events, which userspace reads and later reads sysfs entry to know if
playback or capture has stopped or started by host application.

/config/usb_gadget/g1/functions/uac2.0 # cat c_status
1  --> capture started
0  --> capture stopped
/config/usb_gadget/g1/functions/uac2.0 # cat p_status
1 --> playback started
0 --> playback stopped

Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
---
 .../ABI/testing/configfs-usb-gadget-uac2      |  4 ++
 drivers/usb/gadget/function/f_uac2.c          | 47 +++++++++++++++++++
 drivers/usb/gadget/function/u_uac2.h          |  5 ++
 3 files changed, 56 insertions(+)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uac2 b/Documentation/ABI/testing/configfs-usb-gadget-uac2
index 2bfdd4efa9bd..196c6921a163 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-uac2
+++ b/Documentation/ABI/testing/configfs-usb-gadget-uac2
@@ -10,3 +10,7 @@ Description:
 		p_chmask - playback channel mask
 		p_srate - playback sampling rate
 		p_ssize - playback sample size (bytes)
+		c_status - usb uac2 audio capture state
+			   (0: capture stopped, 1: capture started)
+		p_status - usb uac2 audio playback state
+			   (0: playback stopped, 1: playback started)
diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index db2d4980cb35..f1f7631e9380 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -739,6 +739,8 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
 	struct usb_gadget *gadget = cdev->gadget;
 	struct device *dev = &gadget->dev;
 	int ret = 0;
+	struct f_uac2_opts *audio_opts =
+		container_of(fn->fi, struct f_uac2_opts, func_inst);
 
 	/* No i/f has more than 2 alt settings */
 	if (alt > 1) {
@@ -762,6 +764,8 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
 			ret = u_audio_start_capture(&uac2->g_audio);
 		else
 			u_audio_stop_capture(&uac2->g_audio);
+		audio_opts->c_status = alt;
+		schedule_work(&audio_opts->work);
 	} else if (intf == uac2->as_in_intf) {
 		uac2->as_in_alt = alt;
 
@@ -769,6 +773,8 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
 			ret = u_audio_start_playback(&uac2->g_audio);
 		else
 			u_audio_stop_playback(&uac2->g_audio);
+		audio_opts->p_status = alt;
+		schedule_work(&audio_opts->work);
 	} else {
 		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 		return -EINVAL;
@@ -801,11 +807,16 @@ static void
 afunc_disable(struct usb_function *fn)
 {
 	struct f_uac2 *uac2 = func_to_uac2(fn);
+	struct f_uac2_opts *audio_opts =
+		container_of(fn->fi, struct f_uac2_opts, func_inst);
 
 	uac2->as_in_alt = 0;
 	uac2->as_out_alt = 0;
+	audio_opts->p_status = 0;//alt;
+	audio_opts->c_status = 0; //alt;
 	u_audio_stop_capture(&uac2->g_audio);
 	u_audio_stop_playback(&uac2->g_audio);
+	schedule_work(&audio_opts->work);
 }
 
 static int
@@ -1036,6 +1047,25 @@ UAC2_ATTRIBUTE(c_srate);
 UAC2_ATTRIBUTE(c_ssize);
 UAC2_ATTRIBUTE(req_number);
 
+#define UAC2_ATTRIBUTE_RO(name)                                         \
+	static ssize_t f_uac2_opts_##name##_show(                       \
+			struct config_item *item,                       \
+			char *page)                                     \
+{                                                                       \
+	struct f_uac2_opts *opts = to_f_uac2_opts(item);                \
+	int result;                                                     \
+									\
+	mutex_lock(&opts->lock);                                        \
+	result = scnprintf(page, PAGE_SIZE, "%u\n", opts->name);        \
+	mutex_unlock(&opts->lock);                                      \
+									\
+	return result;                                                  \
+}                                                                       \
+CONFIGFS_ATTR_RO(f_uac2_opts_, name)
+
+UAC2_ATTRIBUTE_RO(c_status);
+UAC2_ATTRIBUTE_RO(p_status);
+
 static struct configfs_attribute *f_uac2_attrs[] = {
 	&f_uac2_opts_attr_p_chmask,
 	&f_uac2_opts_attr_p_srate,
@@ -1044,6 +1074,8 @@ static struct configfs_attribute *f_uac2_attrs[] = {
 	&f_uac2_opts_attr_c_srate,
 	&f_uac2_opts_attr_c_ssize,
 	&f_uac2_opts_attr_req_number,
+	&f_uac2_opts_attr_c_status,
+	&f_uac2_opts_attr_p_status,
 	NULL,
 };
 
@@ -1053,11 +1085,23 @@ static const struct config_item_type f_uac2_func_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static void f_uac2_audio_status_change_work(struct work_struct *data)
+{
+	struct f_uac2_opts *audio_opts =
+		container_of(data, struct f_uac2_opts, work);
+	char *envp[2] = { "UAC2_STATE=Changed", NULL };
+
+	kobject_uevent_env(&audio_opts->device->kobj,
+			KOBJ_CHANGE, envp);
+}
+
 static void afunc_free_inst(struct usb_function_instance *f)
 {
 	struct f_uac2_opts *opts;
 
 	opts = container_of(f, struct f_uac2_opts, func_inst);
+	device_destroy(opts->device->class, opts->device->devt);
+	cancel_work_sync(&opts->work);
 	kfree(opts);
 }
 
@@ -1082,6 +1126,9 @@ static struct usb_function_instance *afunc_alloc_inst(void)
 	opts->c_srate = UAC2_DEF_CSRATE;
 	opts->c_ssize = UAC2_DEF_CSSIZE;
 	opts->req_number = UAC2_DEF_REQ_NUM;
+	INIT_WORK(&opts->work, f_uac2_audio_status_change_work);
+	opts->device = create_function_device("f_uac2");
+
 	return &opts->func_inst;
 }
 
diff --git a/drivers/usb/gadget/function/u_uac2.h b/drivers/usb/gadget/function/u_uac2.h
index b5035711172d..3ccf2eb002f1 100644
--- a/drivers/usb/gadget/function/u_uac2.h
+++ b/drivers/usb/gadget/function/u_uac2.h
@@ -36,6 +36,11 @@ struct f_uac2_opts {
 
 	struct mutex			lock;
 	int				refcnt;
+	int				c_status;
+	int				p_status;
+	struct device			*device;
+	struct work_struct		work;
 };
 
+extern struct device *create_function_device(char *name);
 #endif
-- 
2.17.1

