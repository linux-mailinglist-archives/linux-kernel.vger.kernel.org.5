Return-Path: <linux-kernel+bounces-7589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D0D81AAA6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4541C22E74
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8436DCE7;
	Wed, 20 Dec 2023 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fsotbsCF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE6054BEA;
	Wed, 20 Dec 2023 22:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BKMfxr9027434;
	Wed, 20 Dec 2023 22:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=ixhtTOGnX7P4tTWs6onH
	ajKULSzgWNdIoPOGbkKKvDM=; b=fsotbsCFk0dfTel0P6Gvk3bDJCYXutJ6JxYK
	lcLk7U0JTp4PY7g3EtQN3h30HXVsmETIGUHQ2y+9jFgK4cPIHbA71UKPeEL4B4Vr
	DYSs96UarsUwXzZaki4IXob67K1ftLOm7CuVU5fciwrLW+jJ6qvfuBD3qYsbZLT0
	z3EMsxhl4Gavkx8PAxsrF/h3iH8YXSjU1/jL6NclbopQWjojdIL6PmA/BOIJEmiB
	2Q6Nxii+8+EV2UnPFUUVHClWOmF6Yf9j1fcm0HxXQUCQxuPWmxp3WG8S/dQkwO8O
	FkjYqfrHNKZsak5ST69KCHEx9GFM3+xQfbO/Q7ZL/ZLE7vEGeg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4837g505-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 22:46:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BKMk6Q8032049
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 22:46:06 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Dec 2023 14:46:06 -0800
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <gregkh@linuxfoundation.org>, <lgirdwood@gmail.com>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@linaro.org>, <Thinh.Nguyen@synopsys.com>,
        <broonie@kernel.org>, <bgoswami@quicinc.com>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <agross@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v11 41/41] ASoC: doc: Add documentation for SOC USB
Date: Wed, 20 Dec 2023 14:45:44 -0800
Message-ID: <20231220224544.18031-42-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231220224544.18031-1-quic_wcheng@quicinc.com>
References: <20231220224544.18031-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v4L2v_WjEbChK28z0Kye1-YzxPImuaeF
X-Proofpoint-ORIG-GUID: v4L2v_WjEbChK28z0Kye1-YzxPImuaeF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312200163

With the introduction of the soc-usb driver, add documentation highlighting
details on how to utilize the new driver and how it interacts with
different components in USB SND and ASoC.  It provides examples on how to
implement the drivers that will need to be introduced in order to enable
USB audio offloading.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 Documentation/sound/soc/index.rst |   1 +
 Documentation/sound/soc/usb.rst   | 611 ++++++++++++++++++++++++++++++
 2 files changed, 612 insertions(+)
 create mode 100644 Documentation/sound/soc/usb.rst

diff --git a/Documentation/sound/soc/index.rst b/Documentation/sound/soc/index.rst
index e57df2dab2fd..8bed8f8f48da 100644
--- a/Documentation/sound/soc/index.rst
+++ b/Documentation/sound/soc/index.rst
@@ -18,3 +18,4 @@ The documentation is spilt into the following sections:-
    jack
    dpcm
    codec-to-codec
+   usb
diff --git a/Documentation/sound/soc/usb.rst b/Documentation/sound/soc/usb.rst
new file mode 100644
index 000000000000..ecff0b221d86
--- /dev/null
+++ b/Documentation/sound/soc/usb.rst
@@ -0,0 +1,611 @@
+================
+ASoC USB support
+================
+
+Overview
+========
+In order to leverage the existing USB sound device support in ALSA, the
+introduction of the ASoC USB APIs, allow for the entities to communicate
+with one another.
+
+One potential use case would be to support USB audio offloading, which is
+an implementation that allows for an external DSP on the SoC to handle the
+transfer of audio data over the USB bus.  This would let the main
+processor to stay in lower power modes for longer durations.  The following
+is an example design of how the ASoC and ALSA pieces can be connected
+together to achieve this:
+
+::
+
+               USB                   |            ASoC
+                                     |  _________________________
+                                     | |   ASoC Platform card    |
+                                     | |_________________________|
+                                     |         |           |
+                                     |      ___V____   ____V____
+                                     |     |ASoC BE | |ASoC FE  |
+                                     |     |DAI LNK | |DAI LNK  |
+                                     |     |________| |_________|
+                                     |         ^  ^        ^
+                                     |         |  |________|
+                                     |      ___V____    |
+                                     |     |SOC-USB |   |
+     ________       ________               |        |   |
+    |USB SND |<--->|USBSND  |<------------>|________|   |
+    |(card.c)|     |offld   |<----------                |
+    |________|     |________|___     | |                |
+        ^               ^       |    | |    ____________V_________
+        |               |       |    | |   |IPC                   |
+     __ V_______________V_____  |    | |   |______________________|
+    |USB SND (endpoint.c)     | |    | |              ^
+    |_________________________| |    | |              |
+                ^               |    | |   ___________V___________
+                |               |    | |->|audio DSP              |
+     ___________V_____________  |    |    |_______________________|
+    |XHCI HCD                 |<-    |
+    |_________________________|      |
+
+
+SOC USB driver
+==============
+Structures
+----------
+``struct snd_soc_usb``
+
+  - ``list``: list head for SND SOC struct list
+  - ``dev``: USB backend device reference
+  - ``component``: reference to ASoC component
+  - ``active_list``: active sessions
+  - ``num_supported_streams``: number of supported concurrent sessions
+  - ``connection_status_cb``: callback to notify connection events
+  - ``put_offload_dev``: callback to select USB sound card/PCM device
+  - ``get_offload_dev``: callback to fetch selected USB sound card/PCM device
+  - ``priv_data``: driver data
+
+The snd_soc_usb structure can be referenced using the ASoC platform card
+device, or a USB device (udev->dev).  This is created by the ASoC BE DAI
+link, and the USB sound entity will be able to pass information to the
+ASoC BE DAI link using this structure.
+
+``struct snd_soc_usb_device``
+
+  - ``card_idx``: sound card index associated with USB device
+  - ``chip_idx``: USB sound chip array index
+  - ``num_playback``: number of playback streams
+  - ``num_capture``: number of capture streams
+
+The struct snd_soc_usb_device is created by the USB sound offload driver.
+This will carry basic parameters/limitations that will be used to
+determine the possible offloading paths for this USB audio device.
+
+``struct snd_soc_usb_session``
+
+  - ``active_card_idx``: active offloaded sound card
+  - ``active_pcm_idx``: active offloaded PCM device
+  - ``state``: USB BE DAI link PCM state
+
+The struct snd_soc_usb_session tracks the current offloading state for a
+particular card and PCM combination.  This structure is carried/saved as
+part of the active_list within struct snd_soc_usb.
+
+The number of entities in the active list corresponds to the number of
+snd_soc_usb_session structures that are allocated.  This is controlled
+by the num_supported_streams that is reported as part of the SOC USB
+structure creation.
+
+Functions
+---------
+.. code-block:: rst
+
+	const char *snd_soc_usb_get_components_tag(bool playback);
+..
+
+  - ``playback``: direction of audio stream
+
+**snd_soc_usb_get_components_tag()** returns the tag used for describing if USB
+offloading is supported for appending to the ASoC platform card's components
+string.
+
+Returns a tag based on the direction of the audio stream.
+
+.. code-block:: rst
+
+	int snd_soc_usb_find_format(int card_idx, struct snd_pcm_hw_params *params,
+			int direction)
+..
+
+  - ``card_idx``: the index into the USB sound chip array.
+  - ``params``: Requested PCM parameters from the USB DPCM BE DAI link
+  - ``direction``: capture or playback
+
+**snd_soc_usb_find_format()** ensures that the requested audio profile being
+requested by the external DSP is supported by the USB device.
+
+Returns 0 on success, and -EOPNOTSUPP on failure.
+
+.. code-block:: rst
+
+	int snd_soc_usb_connect(struct device *usbdev, struct snd_soc_usb_device *sdev)
+..
+
+  - ``usbdev``: the usb device that was discovered
+  - ``sdev``: capabilities of the device
+
+**snd_soc_usb_connect()** notifies the ASoC USB DCPM BE DAI link of a USB
+audio device detection.  This can be utilized in the BE DAI
+driver to keep track of available USB audio devices.  This is intended
+to be called by the USB offload driver residing in USB SND.
+
+Returns 0 on success, negative error code on failure.
+
+.. code-block:: rst
+
+	int snd_soc_usb_disconnect(struct device *usbdev, struct snd_soc_usb_device *sdev)
+..
+
+  - ``usbdev``: the usb device that was removed
+  - ``sdev``: capabilities to free
+
+**snd_soc_usb_disconnect()** notifies the ASoC USB DCPM BE DAI link of a USB
+audio device removal.  This is intended to be called by the USB offload
+driver that resides in USB SND.
+
+.. code-block:: rst
+
+	void *snd_soc_usb_find_priv_data(struct device *usbdev)
+..
+
+  - ``usbdev``: the usb device to reference to find private data
+
+**snd_soc_usb_find_priv_data()** fetches the private data saved to the SOC USB
+device.
+
+Returns pointer to priv_data on success, NULL on failure.
+
+.. code-block:: rst
+
+	int snd_soc_usb_device_offload_available(struct device *dev)
+..
+
+  - ``dev``: the device to find in SOC USB
+
+**snd_soc_usb_device_offload_available()** fetch the sound card number associated
+to the USB BE DAI link.
+
+Returns a valid sound card index on success, negative on failure.
+
+.. code-block:: rst
+
+	int snd_soc_usb_prepare_session(struct snd_soc_usb *usb, int card_idx, int pcm_idx);
+..
+
+  - ``usb``: SOC USB device
+  - ``card_idx``: USB sound card index
+  - ``pcm_idx``: USB PCM device index
+
+**snd_soc_usb_prepare_session()** populates active_list with a 'struct
+snd_soc_usb_session.'  This will move the session into the SND_SOC_USB_PREPARED
+state.  State updates will always start here.
+
+Returns index to active_list on success, -EBUSY on failure.
+
+.. code-block:: rst
+
+	int snd_soc_usb_shutdown_session(struct snd_soc_usb *usb, int session_id);
+..
+
+  - ``usb``: SOC USB device
+  - ``session_id``: session id returned by **snd_soc_usb_prepare_session()**
+
+**snd_soc_usb_shutdown_session()** frees up a slot in active_list, which signals
+that there is no longer an active offloading device.  This allows for another
+session to be started.
+
+Returns 0 on success, -EINVAL if session index is invalid.
+
+.. code-block:: rst
+
+	int snd_soc_usb_set_session_state(struct snd_soc_usb *usb, int session_id,
+						enum snd_soc_usb_dai_state state);
+..
+
+  - ``usb``: SOC USB device
+  - ``session_id``: session id returned by **snd_soc_usb_prepare_session()**
+  - ``state``: state to move into
+
+**snd_soc_usb_set_session_state()** moves an offloading session to the desired
+state.
+
+.. code-block:: rst
+
+int snd_soc_usb_setup_offload_jack(struct snd_soc_component *component,
+					struct snd_soc_jack *jack)
+..
+
+  - ``component``: ASoC component to add the jack
+  - ``jack``: ASoC sound jack to add
+
+**snd_soc_usb_setup_offload_jack()** is a helper to add a sound jack control to
+the platform sound card.  This will allow for consistent naming to be used on
+designs that support USB audio offloading.
+
+Returns 0 on success, negative otherwise.
+
+.. code-block:: rst
+
+	struct snd_soc_usb *snd_soc_usb_allocate_port(struct snd_soc_component *component,
+			int num_supported_streams, void *data);
+..
+
+  - ``component``: DPCM BE DAI link component
+  - ``num_supported_streams``: number of active streams supported by external DSP
+  - ``data``: private data
+
+**snd_soc_usb_allocate_port()** allocates a SOC USB device and populates standard
+parameters that is used for further operations.
+
+Returns a pointer to struct soc_usb on success, negative on error.
+
+.. code-block:: rst
+
+	void snd_soc_usb_free_port(struct snd_soc_usb *usb);
+..
+
+  - ``usb``: SOC USB device to free
+
+**snd_soc_usb_free_port()** frees a SOC USB device.
+
+.. code-block:: rst
+
+	int snd_soc_usb_add_port(struct snd_soc_usb *usb);
+..
+
+  - ``usb``: SOC USB device to add
+
+**snd_soc_usb_add_port()** add an allocated SOC USB device to the SOC USB framework.
+Once added, this device can be referenced by further operations.
+
+.. code-block:: rst
+
+	int snd_soc_usb_remove_port(struct snd_soc_usb *usb);
+..
+
+  - ``usb``: SOC USB device to remove
+
+**snd_soc_usb_remove_port()** removes a SOC USB device from the SOC USB framework.
+After removing a device, any SOC USB operations would not be able to reference the
+device removed.
+
+How to Register to SOC USB
+--------------------------
+The ASoC DPCM USB BE DAI link is the entity responsible for allocating and
+registering the SOC USB device on the component bind.  Likewise, it will
+also be responsible for freeing the allocated resources.  An example can
+be shown below:
+
+.. code-block:: rst
+
+	static int q6usb_component_probe(struct snd_soc_component *component)
+	{
+		...
+		data->usb = snd_soc_usb_allocate_port(component, 1, &data->priv);
+		if (!data->usb)
+			return -ENOMEM;
+
+		usb->connection_status_cb = q6usb_alsa_connection_cb;
+
+		ret = snd_soc_usb_add_port(usb);
+		if (ret < 0) {
+			dev_err(component->dev, "failed to add usb port\n");
+			goto free_usb;
+		}
+		...
+	}
+
+	static void q6usb_component_remove(struct snd_soc_component *component)
+	{
+		...
+		snd_soc_usb_remove_port(data->usb);
+		snd_soc_usb_free_port(data->usb);
+	}
+
+	static const struct snd_soc_component_driver q6usb_dai_component = {
+		.probe = q6usb_component_probe,
+		.remove = q6usb_component_remove,
+		.name = "q6usb-dai-component",
+		...
+	};
+..
+
+BE DAI links can pass along vendor specific information as part of the
+call to allocate the SOC USB device.  This will allow any BE DAI link
+parameters or settings to be accessed by the USB offload driver that
+resides in USB SND.
+
+USB Audio Device Connection Flow
+--------------------------------
+USB devices can be hotplugged into the USB root hub at any point in time.
+The BE DAI link should be aware of the current state of the physical USB
+port, i.e. if there are any USB devices with audio interface(s) connected.
+The following callback can be used to notify the BE DAI link of any change:
+
+	**connection_status_cb()**
+
+This is called whenever there is a USB SND interface bind or remove event,
+using snd_soc_usb_connect() or snd_soc_usb_disconnect():
+
+.. code-block:: rst
+
+	static void qc_usb_audio_offload_probe(struct snd_usb_audio *chip)
+	{
+		...
+		snd_soc_usb_connect(usb_get_usb_backend(udev), sdev);
+		...
+	}
+
+	static void qc_usb_audio_offload_disconnect(struct snd_usb_audio *chip)
+	{
+		...
+		snd_soc_usb_disconnect(usb_get_usb_backend(chip->dev), dev->sdev);
+		...
+	}
+..
+
+In order to account for conditions where driver or device existence is
+not guaranteed, USB SND exposes snd_usb_rediscover_devices() to resend the
+connect events for any identified USB audio interfaces.  Consider the
+the following situtation:
+
+	**usb_audio_probe()**
+	  | --> USB audio streams allocated and saved to usb_chip[]
+	  | --> Propagate connect event to USB offload driver in USB SND
+	  | --> **snd_soc_usb_connect()** exits as USB BE DAI link is not ready
+
+	BE DAI link component probe
+	  | --> DAI link is probed and SOC USB port is allocated
+	  | --> The USB audio device connect event is missed
+
+To ensure connection events are not missed, **snd_usb_rediscover_devices()**
+is executed when the SOC USB device is registered.  Now, when the BE DAI
+link component probe occurs, the following highlights the sequence:
+
+	BE DAI link component probe
+	  | --> DAI link is probed and SOC USB port is allocated
+	  | --> SOC USB device added, and **snd_usb_rediscover_devices()** runs
+
+	**snd_usb_rediscover_devices()**
+	  | --> Traverses through usb_chip[] and for non-NULL entries issue
+	  |     **connection_status_cb()**
+
+In the case where the USB offload driver is unbounded, while USB SND is
+ready, the **snd_usb_rediscover_devices()** is called during module init.
+This allows for the offloading path to also be enabled with the following
+flow:
+
+	**usb_audio_probe()**
+	  | --> USB audio streams allocated and saved to usb_chip[]
+	  | --> Propagate connect event to USB offload driver in USB SND
+	  | --> USB offload driver **NOT** ready!
+
+	BE DAI link component probe
+	  | --> DAI link is probed and SOC USB port is allocated
+	  | --> No USB connect event due to missing USB offload driver
+
+	USB offload driver probe
+	  | --> **qc_usb_audio_offload_init()**
+	  | --> Calls **snd_usb_rediscover_devices()** to notify of devices
+
+Advertising USB Audio Offload Capability
+----------------------------------------
+As the USB audio offloading can potentially reside within the platform ASoC based
+sound card, depending on if there is a USB DPCM backend DAI link existing in the
+platform card definition, then users can utilize the sound card's components string,
+in order to signal that USB offloading is supported by this sound card.
+
+The sound core exposes:
+
+	**snd_ctl_card_info()**
+
+This allows for userspace applications, i.e. amixer, to fetch the components string
+that was created as part of the ASoC platform sound card creation routine.  The
+possible tags that can be seen are:
+
+	- **usbplybkoffld: 1**
+	- **usbcapoffld: 1**
+
+**usbplybkoffld** translates to usb offload playback supported, and **usbcapoffld**
+translates to USB offload capture supported.  Applications can then query the sound
+card for further offload status parameters.
+
+SOC USB and USB Sound Kcontrols
+===============================
+Details
+-------
+SOC USB and USB sound expose a set of SND kcontrols for applications to select
+and fetch the current offloading status for the ASoC platform sound card. Kcontrols
+are split between two layers:
+
+	- USB sound - Notifies the sound card number for the ASoC platform sound
+	  card that it is registered to for supporting audio offload.
+
+	- SOC USB - Maintains the current status of the offload path, and device
+	  (USB sound card and PCM device) information.  This would be the main
+	  card that applications can read to determine offloading capabilities.
+
+Implementation
+--------------
+
+**Example:**
+
+  **Sound Cards**:
+
+	::
+
+	  0 [SM8250MTPWCD938]: sm8250 - SM8250-MTP-WCD9380-WSA8810-VA-D
+                     SM8250-MTP-WCD9380-WSA8810-VA-DMIC
+	  1 [C320M          ]: USB-Audio - Plantronics C320-M
+                     Plantronics Plantronics C320-M at usb-xhci-hcd.1.auto-1, full speed
+
+
+  **Platform Sound Card** - card#0:
+
+	::
+
+	  SNDUSB OFFLD status                     -1, -1 (range -1->32)
+	  SNDUSB OFFLD device select              1, 0 (range -1->32)
+
+
+  **USB Sound Card** - card#1:
+
+	::
+
+	  SNDUSB OFFLD playback available         0 (range -1->32)
+
+
+The platform sound card(card#0) kcontrols are created as part of adding the SOC
+USB device using **snd_soc_usb_add_port()**.  The following kcontrols are defined
+as:
+
+  - ``SNDUSB OFFLD status`` **(R)**: USB sound card and PCM device index pair that
+    defines which USB SND resources are currently offloaded.  If -1, -1 is seen,
+    it signifies that offload is not active.
+  - ``SNDUSB OFFLD device select`` **(R/W)**: USB sound card and PCM device index
+    pair which selects the USB device to initiate offloading on.  If no value is
+    written to the kcontrol, then the last USB device discovered will be chosen.
+
+The USB sound card(card#1) kcontrols are created as USB audio devices are plugged
+into the physical USB port and enumerated.  The kcontrols are defined as:
+
+  - ``SNDUSB OFFLD playback available`` **(R)**: Provides the sound card
+    number/index that supports USB offloading.  Further/follow up queries about
+    the current offload state can be handled by reading the offload status
+    kcontrol exposed by the platform card.
+
+SNDUSB OFFLD device select Kcontrol
+-----------------------------------
+In order to allow for vendor specific implementations on audio offloading device
+selection, the SOC USB layer exposes the following:
+
+.. code-block:: rst
+
+	int (*put_offload_dev)(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol);
+	int (*get_offload_dev)(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol);
+..
+
+These are specific for the **SNDUSB OFFLD device select** kcontrol.
+
+When users issue get/put calls to the kcontrol, the registered SOC USB callbacks
+will execute the registered function calls to the DPCM BE DAI link.
+
+**Callback Registration:**
+
+.. code-block:: rst
+
+	static int q6usb_component_probe(struct snd_soc_component *component)
+	{
+	...
+	usb = snd_soc_usb_allocate_port(component, 1, &data->priv);
+	if (IS_ERR(usb))
+		return -ENOMEM;
+
+	usb->connection_status_cb = q6usb_alsa_connection_cb;
+	usb->put_offload_dev = q6usb_put_offload_dev;
+	usb->get_offload_dev = q6usb_get_offload_dev;
+
+	ret = snd_soc_usb_add_port(usb);
+..
+
+**PUT Callback:**
+
+Can be used to track current device selection, and to issue any external DSP
+commands that might be required for enabling audio offloading.
+
+.. code-block:: rst
+
+	static int q6usb_put_offload_dev(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+	{
+	...
+	if ((cardidx >= 0 && test_bit(cardidx, &data->available_card_slot))) {
+		data->sel_card_idx = cardidx;
+		changed = 1;
+	}
+
+	if ((pcmidx >= 0 && pcmidx < data->status[cardidx].sdev->num_playback)) {
+		data->sel_pcm_idx = pcmidx;
+		changed = 1;
+	}
+..
+
+The above is an example of keeping track of what the userspace entity is
+selecting as the playback device.  This can be later used to pass the information
+along to the external DSP.
+
+
+SNDUSB OFFLD status
+-------------------
+SOC USB exposes APIs for keeping track of the offloading state, and expects this
+to be maintained by the BE DAI link that created/added the SOC USB device.
+
+**SOC USB State Flow Example**
+
+::
+
+     PCM Core              |      BE USB DAI Link      |     SOC USB
+                           |                           |
+  snd_pcm_hw_params --------> dai_link->ops->hw_params --> snd_soc_usb_prepare_session
+                           |                           |   |--> state = SND_SOC_USB_PREPARED
+  ...                      |                           |   |--> slot[0] now active
+                           |                           |
+                           |                           |
+  snd_pcm_do_prepare--------> dai_link->ops->prepare ---> snd_soc_usb_set_session_state
+                           |                           |   |--> state = SND_SOC_USB_RUNNING
+  ...                      |                           |
+                           |                           |
+  snd_pcm_release_substream-> dai_link->ops->shutdown---> snd_soc_usb_shutdown_session
+                           |                           |   |--> state = SND_SOC_USB_IDLE
+                           |                           |   |--> slot[0] now idle
+
+
+When executing the kcontrol get callback, it will loop across the active_list array
+and report to the application for active USB sound card and USB PCM device indexes.
+
+SNDUSB OFFLD playback available
+-------------------------------
+USB sound also creates a kcontrol for applications to help determine which platform
+sound card USB offloading is linked to.  This will allow applications to further
+query the platform sound card for specific information about the current USB offload
+status.
+
+This is added as a separate mixer driver:
+  - mixer_usb_offload.c
+  - kcontrol: snd_usb_offload_available_ctl
+
+**snd_usb_offload_available_get()** fetches the associated sound card by utilizing
+the **snd_soc_usb_device_offload_available()** API.
+
+Mixer Examples
+--------------
+
+	::
+
+	  tinymix -D 0 set 'SNDUSB OFFLD device select' 2 0
+
+
+	::
+
+	  tinymix -D 0 get 'SNDUSB OFFLD device select'
+	  --> 2, 0 (range 0->32)
+
+	::
+
+	  tinymix -D 0 get 'SNDUSB OFFLD status'
+	  --> 2, 0 (range -1->32)   [OFFLD active]
+	  --> -1, -1 (range -1->32) [OFFLD idle]
+
+	::
+
+	  tinymix -D 0 get 'SNDUSB OFFLD playback available'
+	  --> 0 (range 0->32)

