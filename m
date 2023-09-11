Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEF579A398
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjIKGjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIKGjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:39:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB194B5;
        Sun, 10 Sep 2023 23:39:02 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B6Fp05018111;
        Mon, 11 Sep 2023 06:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LxjW6MR4GooHtNqHuyQKbO6WceLcFGB2J5mrScPfMCY=;
 b=pwZpoxhfg2KO/MRYeQi1DIH1Q+7y/5KI1VLVQZ5Z21rTdXosvhQ/HCqG9+FYXz6za7j3
 liLGNgM6Eja2swoFXrIFuEb8qV1iJRx3Epcj90XGF+Wf25pFw3AnPimZX/YI2kBTIQV9
 hPz8xWrjWM52r/3HrndXhvFoF1Z0aGHfksYgoYwGGx5Z//HRPDce5aGe8CXsblHvvtAg
 K8w8qWI9Rk1bhKmnZYBioO8hafCVVF87GkoetD4npoxaB4FmtiTsmv7YqT5BjQREt99X
 HLmot696wgEyCXYjz+CWft3adm3yZTXwWH8BGnQ1ZLPfsPIMb7sd+84swZ5TskwTJiTL BA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0ga6jnj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 06:38:59 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38B6cwfZ028323
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 06:38:58 GMT
Received: from [10.239.104.229] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 10 Sep
 2023 23:38:56 -0700
Message-ID: <a196ba54-1250-ea77-6d41-55a5a76b15ae@quicinc.com>
Date:   Mon, 11 Sep 2023 14:38:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] Bluetooth: qca: add support for QCA2066
Content-Language: en-US
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>
References: <20230831043902.145872-1-quic_tjiang@quicinc.com>
From:   Tim Jiang <quic_tjiang@quicinc.com>
In-Reply-To: <20230831043902.145872-1-quic_tjiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: N7-7SD7oHqUKOvVcLz_qtiaDFw-SMCaw
X-Proofpoint-ORIG-GUID: N7-7SD7oHqUKOvVcLz_qtiaDFw-SMCaw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110059
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  marcel , johan, luiz:

   could you help mainline this change ? thank you for the help.


regards.

tim


On 8/31/23 12:39, Tim Jiang wrote:
> This patch adds support for QCA2066 firmware patch and NVM downloading.
> as the RF performance of QCA2066 SOC chip from different foundries may
> vary. Therefore we use different NVM to configure them based on board ID.
>
> Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
> ---
>   drivers/bluetooth/btqca.c   | 76 +++++++++++++++++++++++++++++++++++++
>   drivers/bluetooth/btqca.h   |  4 +-
>   drivers/bluetooth/hci_qca.c | 11 ++++++
>   3 files changed, 90 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 5a35ac4138c6..eeca01c41192 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -205,6 +205,46 @@ static int qca_send_reset(struct hci_dev *hdev)
>   	return 0;
>   }
>   
> +static int qca_read_fw_board_id(struct hci_dev *hdev, u16 *bid)
> +{
> +	u8 cmd;
> +	struct sk_buff *skb;
> +	struct edl_event_hdr *edl;
> +	int err = 0;
> +	u8 bid_len;
> +
> +	cmd = EDL_GET_BID_REQ_CMD;
> +	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, EDL_PATCH_CMD_LEN,
> +				&cmd, 0, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		bt_dev_err(hdev, "Reading QCA board ID failed (%d)", err);
> +		return err;
> +	}
> +
> +	edl = skb_pull_data(skb, sizeof(*edl));
> +	if (!edl) {
> +		bt_dev_err(hdev, "QCA read board ID with no header");
> +		err = -EILSEQ;
> +		goto out;
> +	}
> +
> +	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
> +	    edl->rtype != EDL_GET_BID_REQ_CMD) {
> +		bt_dev_err(hdev, "QCA Wrong packet: %d %d", edl->cresp, edl->rtype);
> +		err = -EIO;
> +		goto out;
> +	}
> +
> +	bid_len = edl->data[0];
> +	*bid = (edl->data[1] << 8) + edl->data[2];
> +	bt_dev_dbg(hdev, "%s: bid len = %x, bid = %x", __func__, bid_len, *bid);
> +
> +out:
> +	kfree_skb(skb);
> +	return err;
> +}
> +
>   int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
>   {
>   	struct sk_buff *skb;
> @@ -574,6 +614,29 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
>   }
>   EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
>   
> +static void qca_generate_nvm_name(struct hci_dev *hdev, char *fwname,
> +		   size_t max_size, struct qca_btsoc_version ver, u16 bid)
> +{
> +	u8 rom_ver;
> +	u32 soc_ver;
> +	const char *variant;
> +
> +	soc_ver = get_soc_ver(ver.soc_id, ver.rom_ver);
> +	rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
> +
> +	if ((le32_to_cpu(ver.soc_id) & 0x0000ff00) == QCA_HSP_GF_SOC_ID)  /* hsp gf chip */
> +		variant = "g";
> +	else
> +		variant = "";
> +
> +	if (bid == 0x0)
> +		snprintf(fwname, max_size, "qca/hpnv%02x%s.bin", rom_ver, variant);
> +	else
> +		snprintf(fwname, max_size, "qca/hpnv%02x%s.%x", rom_ver, variant, bid);
> +
> +	bt_dev_dbg(hdev, "%s: %s", __func__, fwname);
> +}
> +
>   int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>   		   enum qca_btsoc_type soc_type, struct qca_btsoc_version ver,
>   		   const char *firmware_name)
> @@ -582,6 +645,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>   	int err;
>   	u8 rom_ver = 0;
>   	u32 soc_ver;
> +	u16 boardid = 0;
>   
>   	bt_dev_dbg(hdev, "QCA setup on UART");
>   
> @@ -615,6 +679,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>   		snprintf(config.fwname, sizeof(config.fwname),
>   			 "qca/apbtfw%02x.tlv", rom_ver);
>   		break;
> +	case QCA_QCA2066:
> +		snprintf(config.fwname, sizeof(config.fwname),
> +			 "qca/hpbtfw%02x.tlv", rom_ver);
> +		break;
>   	case QCA_QCA6390:
>   		snprintf(config.fwname, sizeof(config.fwname),
>   			 "qca/htbtfw%02x.tlv", rom_ver);
> @@ -649,6 +717,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>   	/* Give the controller some time to get ready to receive the NVM */
>   	msleep(10);
>   
> +	if (soc_type == QCA_QCA2066)
> +		qca_read_fw_board_id(hdev, &boardid);
> +
>   	/* Download NVM configuration */
>   	config.type = TLV_TYPE_NVM;
>   	if (firmware_name) {
> @@ -671,6 +742,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>   			snprintf(config.fwname, sizeof(config.fwname),
>   				 "qca/apnv%02x.bin", rom_ver);
>   			break;
> +		case QCA_QCA2066:
> +			qca_generate_nvm_name(hdev, config.fwname,
> +				sizeof(config.fwname), ver, boardid);
> +			break;
>   		case QCA_QCA6390:
>   			snprintf(config.fwname, sizeof(config.fwname),
>   				 "qca/htnv%02x.bin", rom_ver);
> @@ -702,6 +777,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>   
>   	switch (soc_type) {
>   	case QCA_WCN3991:
> +	case QCA_QCA2066:
>   	case QCA_QCA6390:
>   	case QCA_WCN6750:
>   	case QCA_WCN6855:
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index 03bff5c0059d..ea8b8c6fdd89 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -12,6 +12,7 @@
>   #define EDL_PATCH_VER_REQ_CMD		(0x19)
>   #define EDL_PATCH_TLV_REQ_CMD		(0x1E)
>   #define EDL_GET_BUILD_INFO_CMD		(0x20)
> +#define EDL_GET_BID_REQ_CMD			(0x23)
>   #define EDL_NVM_ACCESS_SET_REQ_CMD	(0x01)
>   #define EDL_PATCH_CONFIG_CMD		(0x28)
>   #define MAX_SIZE_PER_TLV_SEGMENT	(243)
> @@ -47,7 +48,7 @@
>   	((le32_to_cpu(soc_id) << 16) | (le16_to_cpu(rom_ver)))
>   
>   #define QCA_FW_BUILD_VER_LEN		255
> -
> +#define QCA_HSP_GF_SOC_ID			0x1200
>   
>   enum qca_baudrate {
>   	QCA_BAUDRATE_115200 	= 0,
> @@ -146,6 +147,7 @@ enum qca_btsoc_type {
>   	QCA_WCN3990,
>   	QCA_WCN3998,
>   	QCA_WCN3991,
> +	QCA_QCA2066,
>   	QCA_QCA6390,
>   	QCA_WCN6750,
>   	QCA_WCN6855,
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 4b57e15f9c7a..067e248e3599 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1841,6 +1841,10 @@ static int qca_setup(struct hci_uart *hu)
>   	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
>   
>   	switch (soc_type) {
> +	case QCA_QCA2066:
> +		soc_name = "qca2066";
> +		break;
> +
>   	case QCA_WCN3988:
>   	case QCA_WCN3990:
>   	case QCA_WCN3991:
> @@ -2032,6 +2036,11 @@ static const struct qca_device_data qca_soc_data_wcn3998 __maybe_unused = {
>   	.num_vregs = 4,
>   };
>   
> +static const struct qca_device_data qca_soc_data_qca2066 __maybe_unused = {
> +	.soc_type = QCA_QCA2066,
> +	.num_vregs = 0,
> +};
> +
>   static const struct qca_device_data qca_soc_data_qca6390 __maybe_unused = {
>   	.soc_type = QCA_QCA6390,
>   	.num_vregs = 0,
> @@ -2559,6 +2568,7 @@ static SIMPLE_DEV_PM_OPS(qca_pm_ops, qca_suspend, qca_resume);
>   
>   #ifdef CONFIG_OF
>   static const struct of_device_id qca_bluetooth_of_match[] = {
> +	{ .compatible = "qcom,qca2066-bt", .data = &qca_soc_data_qca2066},
>   	{ .compatible = "qcom,qca6174-bt" },
>   	{ .compatible = "qcom,qca6390-bt", .data = &qca_soc_data_qca6390},
>   	{ .compatible = "qcom,qca9377-bt" },
> @@ -2576,6 +2586,7 @@ MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
>   
>   #ifdef CONFIG_ACPI
>   static const struct acpi_device_id qca_bluetooth_acpi_match[] = {
> +	{ "QCOM2066", (kernel_ulong_t)&qca_soc_data_qca2066 },
>   	{ "QCOM6390", (kernel_ulong_t)&qca_soc_data_qca6390 },
>   	{ "DLA16390", (kernel_ulong_t)&qca_soc_data_qca6390 },
>   	{ "DLB16390", (kernel_ulong_t)&qca_soc_data_qca6390 },
